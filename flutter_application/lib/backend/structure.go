package main

type User struct {
	UserID       string    `json:"userID"`
	Username     string    `json:"username"`
	Email        string    `json:"email"`
	Password     string    `json:"password"`
	SmartMeterNo string    `json:"smartMeterNo"`
	GenData      []float64 `json:"genData"`
	UseData      []float64 `json:"useData"`
}

type EnergyRequest struct {
	BidID     string  `json:"bidID"`
	UserID    string  `json:"userID"`
	Energy    float64 `json:"energyAmount"`
	Price     float64 `json:"biddingPrice"`
	BuyOrSell string  `json:"BuyOrSell"`
}

type EnergyPredRequest struct {
	ProdEnergy float64 `json:"prodEnergy"`
	ConsEnergy float64 `json:"consEnergy"`
}

type BiddingRangeRequest struct {
	MaxBuyPrice  float64 `json:"maxBuyPrice"`
	MaxSellPrice float64 `json:"maxSellPrice"`
}

type Block struct {
	Index    int         `json:"index"`
	Hash     string      `json:"hash"`
	PrevHash string      `json:"prevHash"`
	Data     Transaction `json:"data"`
}

type StakeRequest struct {
	Node  int `json:"node"`
	Port  int `json:"port"`
	Stake int `json:"stake"`
}

type PredResult struct {
	GenData float64 `json:"genData"`
	UseData float64 `json:"useData"`
}


type Transaction struct {
	BidID     string  `json:"bidID"`
	UserID    string  `json:"userID"`
	Price     float64 `json:"price"`
	ToGrid    float64 `json:"toGrid"`
	ToMarket  float64 `json:"toMarket"`
	BuyOrSell string  `json:"BuyOrSell"`
}

type UserEnergyData struct {
	GenData []float64 `json:"genData"`
	UseData []float64 `json:"useData"`
}

