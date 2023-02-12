package main

import (
	"bytes"
	"crypto/ecdsa"
	"crypto/elliptic"
	"crypto/rand"
	"crypto/x509"
	"encoding/gob"
	"encoding/pem"
	"fmt"
	"log"
	"os"
)

// Create ListOfNodeInfo.json
/*
Node ID
Node PubKey
Port
*/
// Private key is stored in env

func generateKeyPair() (string, string) {

	pubkeyCurve := elliptic.P256() //see http://golang.org/pkg/crypto/elliptic/#P256
	// keyword := []byte("This should be a unique password for node 1")
	// reader := bytes.NewReader(keyword)

	privatekey := new(ecdsa.PrivateKey)
	privatekey, err := ecdsa.GenerateKey(pubkeyCurve, rand.Reader) // this generates a public & private key pair

	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	var pubkey ecdsa.PublicKey
	pubkey = privatekey.PublicKey

	fmt.Println("Private Key :")
	fmt.Printf("%x \n", privatekey)

	fmt.Println("Public Key :")
	fmt.Printf("%x \n", pubkey)
	PrivKeyInString, PubKeyInString := encode(privatekey, &pubkey)
	return PrivKeyInString, PubKeyInString
}

func signECDSA(newBlock Block) ([]byte, []byte) {
	// Sign ecdsa style
	signHash := EncodeToBytes(newBlock)
	fmt.Println("Can encode block to bytes")
	fmt.Println(MyNodeInfo)
	PrivKeyInPEM, _ := decode(MyNodeInfo.NodePrivKey, MyNodeInfo.NodePubKey)
	signature, err := ecdsa.SignASN1(rand.Reader, PrivKeyInPEM, signHash)
	if err != nil {
		fmt.Println("Error in signing block")
		fmt.Println(err)
	}

	fmt.Printf("Signature : %x\n", signature)
	return signHash, signature
}

func verifyECDSA(signHash []byte, signature []byte, ValidatorNode NodeInfo) bool {
	_, PubKeyInPEM := decode(ValidatorNode.NodePrivKey, ValidatorNode.NodePubKey)
	// Verify
	verifyStatus := ecdsa.VerifyASN1(PubKeyInPEM, signHash, signature)

	fmt.Println(verifyStatus) // should be true
	return verifyStatus
}

func EncodeToBytes(p interface{}) []byte {
	buf := bytes.Buffer{}
	enc := gob.NewEncoder(&buf)
	err := enc.Encode(p)
	if err != nil {
		log.Fatal(err)
	}
	fmt.Println("uncompressed size (bytes): ", len(buf.Bytes()))
	return buf.Bytes()
}

func DecodeToBlock(s []byte) Block {

	p := Block{}
	dec := gob.NewDecoder(bytes.NewReader(s))
	err := dec.Decode(&p)
	if err != nil {
		log.Fatal(err)
	}
	return p
}

func encode(privateKey *ecdsa.PrivateKey, publicKey *ecdsa.PublicKey) (string, string) {
	x509Encoded, _ := x509.MarshalECPrivateKey(privateKey)
	pemEncoded := pem.EncodeToMemory(&pem.Block{Type: "PRIVATE KEY", Bytes: x509Encoded})

	x509EncodedPub, _ := x509.MarshalPKIXPublicKey(publicKey)
	pemEncodedPub := pem.EncodeToMemory(&pem.Block{Type: "PUBLIC KEY", Bytes: x509EncodedPub})

	return string(pemEncoded), string(pemEncodedPub)
}

func decode(pemEncoded string, pemEncodedPub string) (*ecdsa.PrivateKey, *ecdsa.PublicKey) {
	block, _ := pem.Decode([]byte(pemEncoded))
	x509Encoded := block.Bytes
	privateKey, _ := x509.ParseECPrivateKey(x509Encoded)

	blockPub, _ := pem.Decode([]byte(pemEncodedPub))
	x509EncodedPub := blockPub.Bytes
	genericPublicKey, _ := x509.ParsePKIXPublicKey(x509EncodedPub)
	publicKey := genericPublicKey.(*ecdsa.PublicKey)

	return privateKey, publicKey
}
