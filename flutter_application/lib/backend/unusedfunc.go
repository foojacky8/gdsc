package main

// This file consists of function that are no used, however are kept as backup if needed
/*
type Login struct {
	Email    string `json:"email"`
	Password string `json:"password"`
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
func AddUser(newUser User) error {
	_, _, err := dB.Collection("users").Add(context.Background(), map[string]interface{}{
		"userID":       newUser.UserID,
		"username":     newUser.Username,
		"email":        newUser.Email,
		"password":     newUser.Password,
		"smartMeterNo": newUser.SmartMeterNo,
		"genData":      newUser.GenData,
		"useData":      newUser.UseData,
	})
	if err != nil {
		fmt.Println("Failed to add user: ", err)
		return err
	}
	fmt.Println("User added successfully")
	return nil
}
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

	// create unique user id from hashing user's email and username
	userInfo := newUser.Email + newUser.Username
	h := sha256.New()
	h.Write([]byte(userInfo))
	hash := h.Sum(nil)
	newUser.UserID = hex.EncodeToString(hash)

	// obtain generation and usage data randomly from csv file
	newUser.GenData, newUser.UseData = ObtainEnergyData()

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
*/
