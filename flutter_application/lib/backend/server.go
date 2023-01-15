package main

import (
	"encoding/json"
	"fmt"
	"net/http"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()
	r.HandleFunc("/", showData).Methods("GET")
	r.HandleFunc("/login", handleUserLogin).Methods("POST")
	r.HandleFunc("/signUp", handleSignUp).Methods("POST")
	r.HandleFunc("/energyRequest", handleEnergyRequest).Methods("POST")
	r.HandleFunc("/energyForecast", handleEnergyForecast).Methods("POST")
	r.HandleFunc("/biddingRange", handleBiddingRange).Methods("POST")
	r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")
	r.HandleFunc("/verifyJWT", handleVerifyJWT).Methods("GET")
	r.HandleFunc("/initAuction", handleInitAuction).Methods("GET")
	r.HandleFunc("/createRequest", createSomeRequest).Methods("GET")
	return r
}

// Obtain from mycoralhealth website
func showData(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	respondWithJSON(w, r, http.StatusAccepted, SomeData)
}

func handleGetBlockchain(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newBlock Block
	newBlock.Index = 1
	newBlock.Data.Energy = 10
	newBlock.Data.Money = 10
	newBlock.Data.UserID = "A001"
	newBlock.Hash = "asdf"
	newBlock.PrevHash = "qwer"
	Blockchain = append(Blockchain, newBlock)
	respondWithJSON(w, r, http.StatusAccepted, Blockchain)
	fmt.Println(Blockchain)
}

func handleBiddingRange(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var Data UserIDRequest
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&Data); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	defer r.Body.Close()
	var BiddingRange BiddingRangeRequest
	BiddingRange.MaxBuyPrice = 14
	BiddingRange.MaxSellPrice = 17
	respondWithJSON(w, r, http.StatusCreated, BiddingRange)
	fmt.Println(Data)
	return
}

func handleEnergyForecast(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var Data UserIDRequest
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&Data); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	defer r.Body.Close()
	var ForecastedEnergy EnergyPredRequest
	ForecastedEnergy.ConsEnergy = 20
	ForecastedEnergy.ProdEnergy = 15
	respondWithJSON(w, r, http.StatusCreated, ForecastedEnergy)
	fmt.Println(Data)
	return
}

// Obtain from mycoralhealth website, simply return the HTTP status and data to the front end
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
