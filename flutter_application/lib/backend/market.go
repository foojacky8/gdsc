package main

import (
	"encoding/json"
	"fmt"
	"net/http"
	"os"
	"os/exec"
	"strconv"
)

var ListOfReq []EnergyRequest

func handleEnergyRequest(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newEnergyReq EnergyRequest
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&newEnergyReq); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	userID, err := verifyJWT(w, r)
	if err != nil {
		fmt.Println(err)
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	defer r.Body.Close()
	newEnergyReq.UserID = userID
	newEnergyReq.BidID = "BD " + strconv.Itoa(len(ListOfReq)+1)
	ListOfReq = append(ListOfReq, newEnergyReq)
	respondWithJSON(w, r, http.StatusCreated, newEnergyReq)
	return
}

func createSomeRequest(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newRequest EnergyRequest
	newRequest.BidID = "BD 1"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Buy"
	newRequest.Energy = 10.0
	newRequest.Price = 0.48
	ListOfReq = append(ListOfReq, newRequest)
	newRequest.BidID = "BD 2"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Buy"
	newRequest.Energy = 20.0
	newRequest.Price = 0.36
	ListOfReq = append(ListOfReq, newRequest)
	newRequest.BidID = "BD 3"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Buy"
	newRequest.Energy = 20.0
	newRequest.Price = 0.4
	ListOfReq = append(ListOfReq, newRequest)
	newRequest.BidID = "BD 4"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Sell"
	newRequest.Energy = 10.0
	newRequest.Price = 0.47
	ListOfReq = append(ListOfReq, newRequest)
	newRequest.BidID = "BD 5"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Sell"
	newRequest.Energy = 10.0
	newRequest.Price = 0.38
	ListOfReq = append(ListOfReq, newRequest)
	newRequest.BidID = "BD 6"
	newRequest.UserID = "sdhsdjjsk"
	newRequest.BuyOrSell = "Sell"
	newRequest.Energy = 60.0
	newRequest.Price = 0.33
	ListOfReq = append(ListOfReq, newRequest)
}

func handleInitAuction(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")

	//write energy request into csv file
	var empDataBuy [][]string
	var BuyBidIDList []string
	var BuyEnergyList []string
	var BuyBiddingPriceList []string
	var empDataSell [][]string
	var SellBidIDList []string
	var SellEnergyList []string
	var SellBiddingPriceList []string
	BuyBidIDList = append(BuyBidIDList, "Bid ID")
	BuyEnergyList = append(BuyEnergyList, "Energy")
	BuyBiddingPriceList = append(BuyBiddingPriceList, "Price")
	SellBidIDList = append(SellBidIDList, "Bid ID")
	SellEnergyList = append(SellEnergyList, "Energy")
	SellBiddingPriceList = append(SellBiddingPriceList, "Price")

	for i := 0; i < len(ListOfReq); i++ {
		if ListOfReq[i].BuyOrSell == "Buy" {
			// write to BuyReq.csv
			BuyBidIDList = append(BuyBidIDList, ListOfReq[i].BidID)
			BuyEnergyList = append(BuyEnergyList, fmt.Sprintf("%v", ListOfReq[i].Energy))
			BuyBiddingPriceList = append(BuyBiddingPriceList, fmt.Sprintf("%v", ListOfReq[i].Price))
		} else if ListOfReq[i].BuyOrSell == "Sell" {
			SellBidIDList = append(SellBidIDList, ListOfReq[i].BidID)
			SellEnergyList = append(SellEnergyList, fmt.Sprintf("%v", ListOfReq[i].Energy))
			SellBiddingPriceList = append(SellBiddingPriceList, fmt.Sprintf("%v", ListOfReq[i].Price))
		}
	}
	empDataBuy = append(empDataBuy, BuyBidIDList)
	empDataBuy = append(empDataBuy, BuyEnergyList)
	empDataBuy = append(empDataBuy, BuyBiddingPriceList)
	empDataBuy = transpose(empDataBuy)
	empDataSell = append(empDataSell, SellBidIDList)
	empDataSell = append(empDataSell, SellEnergyList)
	empDataSell = append(empDataSell, SellBiddingPriceList)
	empDataSell = transpose(empDataSell)
	fmt.Println(empDataBuy)
	fmt.Println(empDataSell)
	WritetoCSV(empDataBuy, "BuyReq.csv")
	WritetoCSV(empDataSell, "SellReq.csv")

	// Call the Python script to run auction.py
	cmd := exec.Command("python", "auction.py")
	cmd.Stdout = os.Stdout
	cmd.Stderr = os.Stderr
	err := cmd.Run()
	if err != nil {
		fmt.Println(err)
	}

}
