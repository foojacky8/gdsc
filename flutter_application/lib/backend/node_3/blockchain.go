package main

import (
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
	"reflect"
	"strconv"
	"time"
)

// create a genesis block
func createGenesisBlock() Block {
	var genesisTransaction Transaction
	genesisTransaction.BidID = ""
	genesisTransaction.UserID = ""
	genesisTransaction.Price = 0.0
	genesisTransaction.ToGrid = 0.0
	genesisTransaction.ToMarket = 0.0

	var genesisTransactionList []Transaction
	genesisTransactionList = append(genesisTransactionList, genesisTransaction)

	var genesisBlock Block
	genesisBlock.Data = genesisTransactionList
	genesisBlock.Index = 0
	genesisBlock.PrevHash = ""
	genesisBlock.Hash = calculateHash(genesisBlock)
	genesisBlock.Miner = ""
	genesisBlock.Timestamp = time.Now().String()

	return genesisBlock
}

// This function receives the new block from the winning node
// and verifies it be4 appending to individual blockchain
func handleAppendBlockchain(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	// Retrieve the signed block from the winning node
	var ReceivedReq signatureReq
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&ReceivedReq); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}

	// Verify the ECDSA signature validity
	var signatureValidity bool
	// Get Node Info based on Node ID
	for i := 0; i < len(ListOfNodeInfo); i++ {
		if ListOfNodeInfo[i].NodeID == ReceivedReq.NodeID {
			signatureValidity = verifyECDSA(ReceivedReq.SignHash, ReceivedReq.Signature, ListOfNodeInfo[i])
		}
	}
	// If the signature is verified to be correct, proceed with checking the content of the block
	if signatureValidity {
		fmt.Println("Success verifying signature")
	}
	// Decode the block from signHash
	ReceivedBlock := DecodeToBlock(ReceivedReq.SignHash)
	fmt.Println(ReceivedBlock)
	fmt.Println("Can convert to struct")
	TransactionInString := stringifyData(ReceivedBlock.Data)
	TransactionHash := createHash(TransactionInString)
	data, _ := json.MarshalIndent(TransactionHash, "", "  ")
	reader := bytes.NewReader(data)
	resp, err := http.Post("http://localhost:8000/verifyTransaction", "application/json", reader)
	if err != nil {
		fmt.Println(err)
	}
	if resp.StatusCode == 202 {
		fmt.Println("Transaction Data is correct")
		fmt.Println("Ready to append new block to my blockchain")
		http.Get("http://localhost:8000/readyToAppend")
		Blockchain = append(Blockchain, ReceivedBlock)
		writejson(Blockchain, "Blockchain.json")
	} else {
		fmt.Println("Transaction Data is incorrect")
		fmt.Println("Notifying main server to restart PoS")
		http.Get("http://localhost:8000/initPoS")
	}

}

func createBlock() Block {
	fmt.Println(Blockchain)
	var newBlock Block
	newBlock.Data = TransactionData
	newBlock.Index = Blockchain[len(Blockchain)-1].Index + 1
	newBlock.PrevHash = Blockchain[len(Blockchain)-1].Hash
	newBlock.Miner = MyNodeInfo.NodeID
	newBlock.Timestamp = time.Now().String()
	newBlock.Hash = calculateHash(newBlock)
	fmt.Println("Can create Block Here")
	return newBlock
}

func calculateHash(block Block) string {
	record := stringifyData(block.Data)
	record = record + strconv.Itoa(block.Index) + block.PrevHash + block.Timestamp + block.Miner
	hashed := createHash(record)
	return hashed
}

func createHash(record string) string {
	h := sha256.New()
	h.Write([]byte(record))
	hashed := h.Sum(nil)
	fmt.Println("Can calculate hash here")
	return hex.EncodeToString(hashed)
}

// convert the data to string, an automated method
func stringifyData(TransactionDataList []Transaction) string {
	var record string
	for i := 0; i < len(TransactionDataList); i++ {
		v := reflect.ValueOf(TransactionDataList[i])
		// v.Type() gives the field name
		for j := 0; j < v.NumField(); j++ {
			record = record + fmt.Sprintf("%v", v.Field(j).Interface())
		}
	}
	fmt.Println("Can stringify data here")
	return record
}

// Price & Profit calculations
func calculateAmount (BuyOrSell string, Price float64, ToGrid float64, ToMarket float64) float64 {
	if BuyOrSell == "Buy" {
		// Price
		return ToMarket * Price + ToGrid * 0.5
	} else if BuyOrSell == "Sell" {
		// Profit
		return ToMarket * Price + ToGrid * 0.3
	} else {
		return 0.0
	}
}

// Bytes for encoding
var bytes = []byte{35, 46, 57, 24, 85, 35, 24, 74, 87, 35, 88, 98, 66, 32, 14, 05}

// Function to Encode Struct to String
func Encode(b []byte) string {
	return base64.StdEncoding.EncodeToString(b)
}

// Encrypt method is to encrypt or hide any classified text
func Encrypt(text, MySecret string) (string, error) {
	block, err := aes.NewCipher([]byte(MySecret))
	if err != nil {
		return "", err
	}
	plainText := []byte(text)
	cfb := cipher.NewCFBEncrypter(block, bytes)
	cipherText := make([]byte, len(plainText))
	cfb.XORKeyStream(cipherText, plainText)
	return Encode(cipherText), nil
   }

// Convert blockchain into a string
func stringifyBlock(block []Block){
	blockString, err := json.Marshal(block)
	if err != nil {
		panic (err)
	}
	fmt.Println(string(blockString))
	return blockString
}

// // SAMPLE CODE TO ENCRYPT AND DECRYPT BLOCKSTRING
// // To encrypt the blockString
// encText, err := Encrypt(blockString, MySecret)
// if err != nil {
//  fmt.Println("error encrypting your classified text: ", err)
// }
// fmt.Println(encText)
// // To decrypt the original blockString
// decText, err := Decrypt("Li5E8RFcV/EPZY/neyCXQYjrfa/atA==", MySecret)
// if err != nil {
//  fmt.Println("error decrypting your encrypted text: ", err)
// }
// fmt.Println(decText)