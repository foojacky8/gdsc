package main

import (
	"bytes"
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"strconv"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()
	//
	r.HandleFunc("/getBlockchainHash", handleGetBlockchainHash).Methods("GET")
	r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")
	r.HandleFunc("/wantsToMine", handleWantsToMine).Methods("GET")
	// takes in transaction data as input and create a new block and send to other node
	r.HandleFunc("/mineBlock", mineBlock).Methods("POST")
	r.HandleFunc("/appendBlockchain", handleAppendBlockchain).Methods("POST")
	return r
}

func handleWantsToMine(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var req StakeRequest
	req.Node, _ = strconv.Atoi(os.Getenv("NODE"))
	req.Port, _ = strconv.Atoi(os.Getenv("PORT"))
	req.Stake, _ = strconv.Atoi(os.Getenv("STAKE"))
	respondWithJSON(w, r, http.StatusAccepted, req)
}
func handleGetBlockchain(w http.ResponseWriter, r *http.Request) {

}
func handleGetBlockchainHash(w http.ResponseWriter, r *http.Request) {

}

func mineBlock(w http.ResponseWriter, r *http.Request) {
	// Retrieve the transaction data from http request
	w.Header().Set("Content-Type", "application/json")
	var Data []Transaction
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&Data); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}

	// form a block
	newBlock := createBlock()
	fmt.Println("Done newBlock")

	// sign the new formed block
	signHash, signature := signECDSA(newBlock)
	fmt.Println("Done signing block")

	for i := 0; i < len(ListOfNodeInfo); i++ {
		// Form new HTTP request and send to other nodes
		var newRequest signatureReq
		newRequest.NodeID = "Node_1"
		newRequest.SignHash = signHash
		newRequest.Signature = signature
		data, _ := json.MarshalIndent(newRequest, "", "  ")
		reader := bytes.NewReader(data)
		http.Post(fmt.Sprintf("http://localhost:%d/appendBlockchain", ListOfNodeInfo[i].Port), "application/json", reader)
	}
	fmt.Println("Done sending POST request")

	// Append the new block to my blockchain
	http.Get("http://localhost:8000/readyToAppend")
	Blockchain = append(Blockchain, newBlock)
	writejson(Blockchain, "Blockchain.json")

}

func respondWithJSON(w http.ResponseWriter, r *http.Request, code int, payload interface{}) {
	response, err := json.MarshalIndent(payload, "", "  ")
	if err != nil {
		w.WriteHeader(http.StatusInternalServerError)
		w.Write([]byte("HTTP 500: Internal Server Error"))
		return
	}
	w.WriteHeader(code)
	w.Write(response)
}
