package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"
)

func run() error {
	mux := makeMuxRouter()
	httpAddr := os.Getenv("PORT")
	log.Println("Listening on ", os.Getenv("PORT"))
	fmt.Println("Listening on ", os.Getenv("PORT"))

	s := &http.Server{
		Addr:           ":" + httpAddr,
		Handler:        mux,
		ReadTimeout:    10 * time.Second,
		WriteTimeout:   10 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	if err := s.ListenAndServe(); err != nil {
		return err
	}

	return nil
}

func main() {
	err := godotenv.Load()
	if err != nil {
		log.Fatal(err)
	}
	err = readjson("transaction.json", "TransactionData")
	err = readjson("OtherNodeInfo.json", "ListOfNodeInfo")
	err = readjson("MyNodeInfo.json", "MyNodeInfo")
	err = readjson("Blockchain.json", "Blockchain")
	// fmt.Println("TransactionData: ", TransactionData)
	// fmt.Println("TransactionData: ", CalcAmountTest(TransactionData))
	// fmt.Println("ListOfNodeInfo: ", ListOfNodeInfo)
	// fmt.Println("MyNodeInfo: ", MyNodeInfo)
	if Blockchain == nil {
		genesisBlock := createGenesisBlock()
		Blockchain = append(Blockchain, genesisBlock)
	}
	log.Fatal(run())
	//createNodeInfoJSON()

}

func writejson(Data interface{}, Filename string) error {
	jsonFile, _ := json.MarshalIndent(Data, "", " ")

	err := ioutil.WriteFile(Filename, jsonFile, 0644)
	return err
}

func readjson(Filename string, Data string) error {
	//jsonFile, err := os.Open(Filename)
	// if err != nil {
	// 	log.Fatal(err)
	// }
	if Data == "TransactionData" {
		byteValue, _ := ioutil.ReadFile(Filename)
		err := json.Unmarshal(byteValue, &TransactionData)
		if err != nil {
			return err
		}
	} else if Data == "MyNodeInfo" {
		byteValue, _ := ioutil.ReadFile(Filename)
		err := json.Unmarshal(byteValue, &MyNodeInfo)
		if err != nil {
			return err
		}
	} else if Data == "ListOfNodeInfo" {
		byteValue, _ := ioutil.ReadFile(Filename)
		err := json.Unmarshal(byteValue, &ListOfNodeInfo)
		if err != nil {
			return err
		}
	} else if Data == "Blockchain" {
		byteValue, _ := ioutil.ReadFile(Filename)
		err := json.Unmarshal(byteValue, &Blockchain)
		if err != nil {
			return err
		}
	}
	return nil

}

func CalcAmountTest (TransactionData []Transaction) string {
    for i := 0; i < len(TransactionData); i++ {
		fmt.Println(TransactionData[i].BuyOrSell, calculateAmount(TransactionData[i].BuyOrSell, TransactionData[i].Price, TransactionData[i].ToGrid, TransactionData[i].ToMarket))
    }
	return "Calculation Complete"
}
// one time code - create necessary information of nodes
// func createNodeInfoJSON() {
// 	var Node_1 NodeInfo
// 	Node_1.NodeID = "Node_1"
// 	Node_1.NodePrivKey, Node_1.NodePubKey = generateKeyPair()
// 	Node_1.Port = 8001
// 	ListOfNodeInfo = append(ListOfNodeInfo, Node_1)

// 	var Node_2 NodeInfo
// 	Node_2.NodeID = "Node_2"
// 	Node_2.NodePrivKey, Node_2.NodePubKey = generateKeyPair()
// 	Node_2.Port = 8002
// 	ListOfNodeInfo = append(ListOfNodeInfo, Node_2)

// 	var Node_3 NodeInfo
// 	Node_3.NodeID = "Node_3"
// 	Node_3.NodePrivKey, Node_3.NodePubKey = generateKeyPair()
// 	Node_3.Port = 8003
// 	ListOfNodeInfo = append(ListOfNodeInfo, Node_3)

// 	err := writejson(ListOfNodeInfo, "NodeInfo.json")
// 	if err != nil {
// 		fmt.Println(err)
// 	}
// }

var TransactionData []Transaction
var Blockchain []Block
var MyNodeInfo NodeInfo
var ListOfNodeInfo []NodeInfo
