# GDSC Solution Challenge


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
Download the firebase credentials json file from the Google Drive link in the submission form and replace the path in firebase.go
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
