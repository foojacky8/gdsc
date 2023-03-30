# GDSC Solution Challenge

## Instruction to set up the frontend
Download and setup Flutter.
You may refer to the follwing link to do so: https://docs.flutter.dev/get-started/install/windows.
Note that this is assuming the user is using Windows operating system.

### Updating packages
After cloning this repo, user should run the following command in the terminal to get latest packages/dependencies. Make sure you are in the **flutter_application** directory.
```
flutter pub get
```
After that, start the Android emulator. Run the following command in the terminal to start the Flutter app
```
flutter run
```
Note: At this stage, the app cannot fully work yet. The backend needs to be started. Refer to the section below which contains instructions to set up the backend.

## Instruction to set up the backend

### Installation
Download Golang and Python
Install necessary packages in Golang
```
go get firebase.google.com/go/v4
go get github.com/gorilla/mux
github.com/joho/godotenv
gonum.org/v1/gonum/floats
gonum.org/v1/gonum/stat/distuv
```
Install necessary packages in Python
```
pip install mip
pip install pandas
pip install numpy
pip install tensorflow
```
Download the firebase credentials json file from https://drive.google.com/file/d/1BCiaMlrgT7YLDm7iSrDbgoUEurE_iuVM/view?usp=sharing and replace the path in firebase.go
```
opt := option.WithCredentialsFile(<Path_to_firebase_credentials.json>)
```

### Initialisation
Create four terminal
First terminal:
```
cd backend
go run .
```
Second terminal:
```
cd backend/node_1
go run .
```
Third terminal:
```
cd backend/node_2
go run .
```
Fourth terminal:
```
cd backend/node_3
go run .
```
Click the Allow button if there is a pop up warning message

## Start using the app
After starting up the frontend and backend, you may start using the app as a normal user would. If this is your first time, you may create an account to access the features in the app.

**Have fun! Thank you.**
