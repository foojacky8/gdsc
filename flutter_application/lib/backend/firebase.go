package main

import (
	"context"
	"fmt"
	"log"

	firestore "cloud.google.com/go/firestore"
	firebase "firebase.google.com/go"
	"google.golang.org/api/iterator"
	"google.golang.org/api/option"
)

//var Auth *auth.Client
var dB *firestore.Client

func initFirebase() {
	opt := option.WithCredentialsFile("D:/Downloads/p2p-energy-trading-da7e6-firebase-adminsdk-2pf44-478096e9ff.json")
	config := &firebase.Config{ProjectID: "p2p-energy-trading-da7e6"}
	app, err := firebase.NewApp(context.Background(), config, opt)
	if err != nil {
		log.Fatalf("error initializing app: %v\n", err)
	}
	//auth, err := app.Auth(context.Background())
	firestore, err := app.Firestore(context.Background())
	if err != nil {
		fmt.Println("Firebase load error", err)
	}
	//Auth = auth
	dB = firestore
}

// func GetUserById(uid string) {
// 	user, err := Auth.GetUser(context.Background(), uid)
// 	if err != nil {
// 		fmt.Println("Error getting user", uid, err)
// 	}
// 	fmt.Println(user)
// }

// func CreateUser(User) {
// 	params := (&auth.UserToCreate{}).
// 		UID(User.UserID).
// 		Email(User.Email).
// 		Password(User.Password).
// 		SmartMeterNo(User.SmartMeterNo).
// 		Username(User.Username)
// 	u, err := Auth.CreateUser(context.Background(), params)
// 	if err != nil {
// 		fmt.Println("error creating user", err)
// 	}
// 	fmt.Println(u)
// }

func AddUser(newUser User) error {
	_, _, err := dB.Collection("users").Add(context.Background(), map[string]interface{}{
		"userID":       newUser.UserID,
		"username":     newUser.Username,
		"email":        newUser.Email,
		"password":     newUser.Password,
		"smartMeterNo": newUser.SmartMeterNo,
	})
	if err != nil {
		fmt.Println("Failed to add user: ", err)
		return err
	}
	fmt.Println("User added successfully")
	return nil
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

func GetUserByEmail(userEmail string, userPassword string) (User, error) {
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
		if doc.Data()["email"].(string) == userEmail {
			retrieveUserData.Email = doc.Data()["email"].(string)
			retrieveUserData.UserID = doc.Data()["userID"].(string)
			retrieveUserData.Username = doc.Data()["username"].(string)
			retrieveUserData.Password = doc.Data()["password"].(string)
			retrieveUserData.SmartMeterNo = doc.Data()["smartMeterNo"].(string)
			return retrieveUserData, nil
		}
	}
}
