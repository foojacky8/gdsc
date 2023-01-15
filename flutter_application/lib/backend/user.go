package main

import (
	"crypto/sha256"
	"encoding/hex"
	"encoding/json"
	"fmt"
	"net/http"
	"time"

	"github.com/golang-jwt/jwt"
)

// This module contains function related to user account

// Create new account for user and store in database
func handleSignUp(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var newUser User
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&newUser); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	defer r.Body.Close()
	userInfo := newUser.Email + newUser.Username
	h := sha256.New()
	h.Write([]byte(userInfo))
	hash := h.Sum(nil)
	newUser.UserID = hex.EncodeToString(hash)
	err := AddUser(newUser)
	if err != nil {
		fmt.Println(err)
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	jwToken, err := generateJWT(newUser)
	if err != nil {
		fmt.Println(err)
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	} else {
		respondWithJSON(w, r, http.StatusAccepted, jwToken)
		return
	}
}

func handleUserLogin(w http.ResponseWriter, r *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	var loginRequest Login
	decoder := json.NewDecoder(r.Body)
	if err := decoder.Decode(&loginRequest); err != nil {
		fmt.Println("Error occured")
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	defer r.Body.Close()
	userData, err := GetUserByEmail(loginRequest.Email, loginRequest.Password)
	if err != nil {
		fmt.Println(err)
		respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		return
	}
	if userData.Password == loginRequest.Password {
		fmt.Println("Login successful")
		fmt.Println("Generating jwtToken")
		jwtToken, err := generateJWT(userData)
		if err != nil {
			respondWithJSON(w, r, http.StatusBadRequest, r.Body)
		} else {
			respondWithJSON(w, r, http.StatusAccepted, jwtToken)
			return
		}
	}
	respondWithJSON(w, r, http.StatusBadRequest, r.Body)
	return
}

func generateJWT(userData User) (string, error) {
	var secretKey = []byte("DoNotShareThis")
	token := jwt.New(jwt.SigningMethodHS256)
	claims := token.Claims.(jwt.MapClaims)
	claims["exp"] = time.Now().Add(24 * time.Hour).Unix()
	claims["authorized"] = true
	claims["userid"] = userData.UserID
	tokenString, err := token.SignedString(secretKey)
	if err != nil {
		fmt.Println("This error: ", err)
		return "", err
	}
	return tokenString, nil
}

func handleVerifyJWT(w http.ResponseWriter, r *http.Request) {
	userid, err := verifyJWT(w, r)
	print(userid)
	if err != nil {
		fmt.Println(err)
		respondWithJSON(w, r, http.StatusUnauthorized, "")
		return
	}
	if userid == "" {
		fmt.Println("Cannot get user id")
		respondWithJSON(w, r, http.StatusUnauthorized, "")
		return
	}
	respondWithJSON(w, r, http.StatusAccepted, userid)
	return

}

func verifyJWT(_ http.ResponseWriter, request *http.Request) (string, error) {
	if request.Header["Token"] != nil {
		tokenString := request.Header["Token"][0]
		token, err := jwt.Parse(tokenString, func(token *jwt.Token) (interface{}, error) {

			if token.Method != jwt.SigningMethodHS256 {
				return nil, fmt.Errorf("there's an error with the signing method")
			}
			return []byte("DoNotShareThis"), nil
		})
		if err != nil {
			return "", err
		}
		claims, ok := token.Claims.(jwt.MapClaims)
		if ok && token.Valid {
			userid := claims["userid"].(string)
			return userid, nil
		}
	}
	return "", nil
}
