package main

import (
	"bytes"
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
