package main

import (
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
)

// This is a handle function to start Proof Of Stake algo
func handleInitPoS(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var ListOfNodesPort []int
	ListOfNodesPort = append(ListOfNodesPort, 8001)
	//ListOfNodesPort = append(ListOfNodesPort, 8002)
	//ListOfNodesPort = append(ListOfNodesPort, 8003)

	for i := 0; i < len(ListOfNodesPort); i++ {
		// Ask the node on how much stake they are willing to put in
		req, err := http.Get(fmt.Sprintf("http://localhost:%d/wantsToMine", ListOfNodesPort[i]))
		var stake StakeRequest
		decoder := json.NewDecoder(req.Body)
		if err := decoder.Decode(&stake); err != nil {
			fmt.Println("Error occured")
			respondWithJSON(w, r, http.StatusBadRequest, r.Body)
			return
		}
		defer r.Body.Close()

		// Append their information into a List
		ListOfValidators = append(ListOfValidators, stake)
		if err != nil {
			fmt.Println(err)
		}
	}
	fmt.Println(ListOfValidators)
	// Pick a winner randomly
	Winner := pickWinner()
	// Read the auction result and send the result to the winning node
	AuctionResult := readAuctionResult()
	data, err := json.MarshalIndent(AuctionResult, "", "  ")
	if err != nil {
		fmt.Println("Error here 1")
		fmt.Println(err)
	}
	reader := bytes.NewReader(data)
	http.Post(fmt.Sprintf("http://localhost:%d/mineBlock", Winner.Port), "application/json", reader)
	return

}

func pickWinner() StakeRequest {
	var Probability []float64
	TotalStake := 0
	for i := 0; i < len(ListOfValidators); i++ {
		TotalStake += ListOfValidators[i].Stake
	}
	for i := 0; i < len(ListOfValidators); i++ {
		Probability = append(Probability, float64(ListOfValidators[i].Stake/TotalStake))
	}
	//min := 1
	//max := len(Probability)
	//winner := rand.Intn(max-min) + min
	winner := 0
	return ListOfValidators[winner]

}

func handleVerifyTransaction(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	var ReceivedTransactionHash string
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&ReceivedTransactionHash); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	fmt.Println("ReceivedTransactionHash: ", ReceivedTransactionHash)
	defer r.Body.Close()
	ActualTransaction := readAuctionResult()
	TransactionInString := stringifyData(ActualTransaction)
	h := sha256.New()
	h.Write([]byte(TransactionInString))
	hashed := h.Sum(nil)
	ActualHash := hex.EncodeToString(hashed)
	if ActualHash == ReceivedTransactionHash {
		respondWithJSON(w, r, http.StatusAccepted, "Correct")
		return
	} else {
		respondWithJSON(w, r, http.StatusBadRequest, "Wrong")
		return
	}
}

var ReceiveDoneCount = 0
var CanProceed = false

func handleDoneAppend(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	ReceiveDoneCount = ReceiveDoneCount + 1
	if ReceiveDoneCount == 2 {
		fmt.Println("All nodes had append blockchain")
		fmt.Println("Can proceed with next block")
		CanProceed = true
	}

}
