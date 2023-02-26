package main

import (
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
	"os/exec"
	"strconv"
)

// This is a handle function to start Proof Of Stake algo
func handleInitPoS(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	for i := 0; i < len(ListOfValidators); i++ {
		// Ask the node on how much stake they are willing to put in
		req, err := http.Get(fmt.Sprintf("http://localhost:%d/wantsToMine", ListOfValidators[i].Port))
		var stake StakeRequest
		decoder := json.NewDecoder(req.Body)
		if err := decoder.Decode(&stake); err != nil {
			fmt.Println("Error occured")
			respondWithJSON(w, r, http.StatusBadRequest, r.Body)
			return
		}
		defer r.Body.Close()
		ListOfValidators[i].Stake = stake.Stake
		if err != nil {
			fmt.Println(err)
		}
	}
	fmt.Println(ListOfValidators)
	// Pick a winner randomly
	Winner := pickWinner(ListOfValidators)
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

func pickWinner(AllStake []StakeRequest) StakeRequest {
	Stake_1 := strconv.Itoa(AllStake[0].Stake)
	Stake_2 := strconv.Itoa(AllStake[1].Stake)
	Stake_3 := strconv.Itoa(AllStake[2].Stake)
	cmd := exec.Command("python", "randomPick.py", Stake_1, Stake_2, Stake_3)
	stdout, err := cmd.Output()
	if err != nil {
		fmt.Println(err)
	}
	s := string(stdout)

	var i int
	if _, err := fmt.Sscanf(s, "%d\r\t", &i); err == nil {
		fmt.Println(i)
	}
	return AllStake[i-1]

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

func handleReadyToAppend(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	ReceiveDoneCount = ReceiveDoneCount + 1
	if ReceiveDoneCount == len(ListOfValidators) {
		fmt.Println("All nodes can proceed to append blockchain")
		fmt.Println("Can proceed with next block")
		CanProceed = true
		ReceiveDoneCount = 0
	}

}
