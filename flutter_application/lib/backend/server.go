package main

import (
	"encoding/json"
	"io/ioutil"
	"net/http"

	"github.com/gorilla/mux"
)

func makeMuxRouter() http.Handler {
	r := mux.NewRouter()

	// return genData and useData to frontend to be stored in database
	r.HandleFunc("/getEnergyData", handleGetEnergyData).Methods("GET")

	// all request below will verify the jwtToken in HTTP request header

	// takes in bid information and append to an array contain all bids
	r.HandleFunc("/energyRequest", handleEnergyRequest).Methods("POST")
	r.HandleFunc("/energyForecast", handleEnergyForecast).Methods("GET")
	//r.HandleFunc("/biddingRange", handleBiddingRange).Methods("POST")
	//r.HandleFunc("/getBlockchain", handleGetBlockchain).Methods("GET")
	r.HandleFunc("/initAuction", handleInitAuction).Methods("GET")
	r.HandleFunc("/clearBlockchain", handleClearBlockchain).Methods("GET")
	r.HandleFunc("/createRequest", createSomeRequest).Methods("GET")
	r.HandleFunc("/initPoS", handleInitPoS).Methods("GET")
	r.HandleFunc("/verifyTransaction", handleVerifyTransaction).Methods("POST")
	r.HandleFunc("/readyToAppend", handleReadyToAppend).Methods("GET")
	return r
}

func handleClearBlockchain(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	jsonFile, _ := json.MarshalIndent(nil, "", " ")

	ioutil.WriteFile("./node_1/Blockchain.json", jsonFile, 0644)
	ioutil.WriteFile("./node_2/Blockchain.json", jsonFile, 0644)
	ioutil.WriteFile("./node_3/Blockchain.json", jsonFile, 0644)
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

// Function to Decode String to Struct
func Decode(s string) []byte {
	data, err := base64.StdEncoding.DecodeString(s)
	if err != nil {
		panic(err)
	}
	return data
}

// Decrypt method is to extract back the encrypted text
func Decrypt(text, MySecret string) (string, error) {
	block, err := aes.NewCipher([]byte(MySecret))
	if err != nil {
		return "", err
	}
	cipherText := Decode(text)
	cfb := cipher.NewCFBDecrypter(block, bytes)
	plainText := make([]byte, len(cipherText))
	cfb.XORKeyStream(plainText, cipherText)
	return string(plainText), nil
}

// Linear search to match strings
// Change the matching to identify majority
func matchBlockString(arr []string) int {

	if len(arr) == 0 {
		fmt.Printf("Array is Empty")
		return
	}

    // Sort the array of strings
    sort.Strings(arr)

    // Count the occurrences of each string
    counts := make(map[string]int)
    for _, str := range arr {
        counts[str]++
    }

    // Find the string with the most occurrences
    maxCount := 0
    maxStr := ""
    for str, count := range counts {
        if count > maxCount {
            maxCount = count
            maxStr = str
        }
    }

    // Return the results
    fmt.Printf("Blockchain with the most occurrences: %s (occurs %d times)\n", maxStr, maxCount)
	return maxStr
}

