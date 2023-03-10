package main

type Login struct {
	Email    string `json:"email"`
	Password string `json:"password"`
}

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

type Transaction struct {
	BidID       string  `json:"bidID"`
	UserID      string  `json:"userID"`
	Price       float64 `json:"price"`
	ToGrid      float64 `json:"toGrid"`
	ToMarket    float64 `json:"toMarket"`
	BuyOrSell   string  `json:"BuyOrSell"`
	TotalAmount float64 `json:"totalAmount"`
}
type Block struct {
	Index           int           `json:"index"`
	Timestamp       string        `json:"timestamp"`
	Hash            string        `json:"hash"`
	PrevHash        string        `json:"prevHash"`
	Data            []Transaction `json:"data"`
	Miner           string        `json:"miner"`
	NoOfTransaction int           `json:"noOfTransaction"`
	TradedEnergy    float64       `json:"tradedEnergy"`
}

type StakeRequest struct {
	Node  string `json:"nodeID"`
	Port  int    `json:"port"`
	Stake int    `json:"stake"`
}

type PredResult struct {
	GenData float64 `json:"genData"`
	UseData float64 `json:"useData"`
}

type UserEnergyData struct {
	GenData []float64 `json:"genData"`
	UseData []float64 `json:"useData"`
}
