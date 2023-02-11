package main

import (
	"context"
	"fmt"
	"log"

	firestore "cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"firebase.google.com/go/auth"
	"google.golang.org/api/iterator"
	"google.golang.org/api/option"
)

var Auth *auth.Client
var dB *firestore.Client

// updated the credentials file path
func initFirebase() {
	opt := option.WithCredentialsFile("E:/gdsc-4b58d-firebase-adminsdk-fctt7-6bbd2ea761.json")
	config := &firebase.Config{ProjectID: "gdsc-4b58d"}
	app, err := firebase.NewApp(context.Background(), config, opt)
	if err != nil {
		log.Fatalf("error initializing app: %v\n", err)
	}
	Auth, err = app.Auth(context.Background())
	if err != nil {
		fmt.Println("Firebase load error", err)
	}
	dB, err = app.Firestore(context.Background())
	if err != nil {
		fmt.Println("Firebase load error", err)
	}
}

func GetEnergyDataById(uid string) (User, error) {
	var retrieveUserData User
	var GenDataInterface []interface{}
	var UseDataInterface []interface{}
	iter := dB.Collection("users").Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			fmt.Println("Cannot found user", err)
			return retrieveUserData, err
		}
		if err != nil {
			fmt.Println("Failed to iterate:", err)
			return retrieveUserData, err
		}
		if doc.Data()["userID"].(string) == uid {
			GenDataInterface = doc.Data()["genData"].([]interface{})
			UseDataInterface = doc.Data()["useData"].([]interface{})
			// type assertion
			for i := 0; i < 24; i++ {
				retrieveUserData.GenData = append(retrieveUserData.GenData, GenDataInterface[i].(float64))
				retrieveUserData.UseData = append(retrieveUserData.UseData, UseDataInterface[i].(float64))
			}
			return retrieveUserData, nil
		}
	}

}
func GetUserById(uid string) (User, error) {
	var retrieveUserData User
	iter := dB.Collection("users").Documents(context.Background())
	for {
		doc, err := iter.Next()
		if err == iterator.Done {
			fmt.Println("Cannot found user", err)
			return retrieveUserData, err
		}
		if err != nil {
			fmt.Println("Failed to iterate:", err)
			return retrieveUserData, err
		}
		if doc.Data()["userID"].(string) == uid {
			retrieveUserData.Email = doc.Data()["email"].(string)
			retrieveUserData.UserID = doc.Data()["userID"].(string)
			retrieveUserData.Username = doc.Data()["username"].(string)
			retrieveUserData.Password = doc.Data()["password"].(string)
			retrieveUserData.SmartMeterNo = doc.Data()["smartMeterNo"].(string)
			return retrieveUserData, nil
		}
	}
}
