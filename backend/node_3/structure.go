package main

type Transaction struct {
	BidID     string  `json:"bidID"`
	UserID    string  `json:"userID"`
	Price     float64 `json:"price"`
	ToGrid    float64 `json:"toGrid"`
	ToMarket  float64 `json:"toMarket"`
	BuyOrSell string  `json:"BuyOrSell"`
}

type Block struct {
	Index     int           `json:"index"`
	Timestamp string        `json:"timestamp"`
	Hash      string        `json:"hash"`
	PrevHash  string        `json:"prevHash"`
	Data      []Transaction `json:"data"`
	Miner     string        `json:"miner"`
}

type StakeRequest struct {
	Node  int `json:"node"`
	Port  int `json:"port"`
	Stake int `json:"stake"`
}

type NodeInfo struct {
	NodeID      string `json:"nodeID"`
	NodePubKey  string `json:"nodePubKey"`
	NodePrivKey string `json:"nodePrivKey"`
	Port        int    `json:"port"`
}

type signatureReq struct {
	NodeID    string `json:"nodeID"`
	SignHash  []byte `json:"signHash"`
	Signature []byte `json:"signature"`
}
