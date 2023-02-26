package main

import (
	"encoding/json"
	"fmt"
	"io/ioutil"
	"log"
	"net/http"
	"os"
	"time"

	"github.com/joho/godotenv"
)

func run() error {
	mux := makeMuxRouter()
	httpAddr := os.Getenv("PORT")
	log.Println("Listening on ", os.Getenv("PORT"))
	fmt.Println("Listening on ", os.Getenv("PORT"))

	s := &http.Server{
		Addr:           ":" + httpAddr,
		Handler:        mux,
		ReadTimeout:    20 * time.Second,
		WriteTimeout:   20 * time.Second,
		MaxHeaderBytes: 1 << 20,
	}

	if err := s.ListenAndServe(); err != nil {
		return err
	}

	return nil
}

func main() {
	err := godotenv.Load()
	initFirebase()
	readjson()
	if err != nil {
		log.Fatal(err)
	}
	log.Fatal(run())

}
func readjson() {
	byteValue, _ := ioutil.ReadFile("NodeInfo.json")
	err := json.Unmarshal(byteValue, &ListOfValidators)
	if err != nil {
		fmt.Println("Error reading json file: ", err)
	}

}

var Blockchain []Block
var ListOfValidators []StakeRequest
