package main

import (
	"encoding/json"
	"flag"
	"fmt"
	"net/http"
	"os"
	"strconv"
	"strings"
)

var studentDb []Student = []Student{}
var personalInfoDb []PersonalInfo = []PersonalInfo{}

type Student struct {
	Name   string `json:"name"`
	School string `json:"school"`
}

var studentSeed []Student = []Student{
	{Name: "Mo", School: "xxx"},
	{Name: "Uki", School: "yyy"},
	{Name: "Jungkook", School: "zzz"},
	{Name: "JK", School: "zzz"},
	{Name: "Ariana Grande", School: "ttt"},
	{Name: "Ariana Gomez", School: "ttt"},
	{Name: "Saoirse Ronan", School: "www"},
	{Name: "Timothee", School: "www"},
	{Name: "IU", School: "xxx"},
}

type PersonalInfo struct {
	Name    string `json:"name"`
	Age     int32 `json:"age"`
	Address string `json:"address"`
}

var personalInfoSeed []PersonalInfo = []PersonalInfo{
	{Name: "Mo", Age: 21, Address: "HN"},
	{Name: "Uki", Age: 21, Address: "ND"},
	{Name: "Jungkook", Age: 25, Address: "BS"},
	{Name: "JK", Age: 25, Address: "LA"},
	{Name: "Ariana Grande", Age: 28, Address: "NY"},
	{Name: "Ariana Gomez", Age: 29, Address: "California"},
	{Name: "Saoirse Ronan", Age: 26, Address: "London"},
	{Name: "Timothee", Age: 24, Address: "Sweden"},
	{Name: "IU", Age: 29, Address: "France"},
}

func manyItems(w http.ResponseWriter, req *http.Request) {
	var name string = req.FormValue("name")
	offset, _ := strconv.Atoi(req.FormValue("offset"))
	limit, _ := strconv.Atoi(req.FormValue("limit"))
	studentRet := []Student{}
	personalInfoRet := []PersonalInfo{}
	if name != "" {
		for _, student := range studentDb {
			if strings.HasPrefix(student.Name,name) {
				studentRet = append(studentRet, student)
			}
		}
		for _, info := range personalInfoDb {
			if strings.HasPrefix(info.Name, name) {
				personalInfoRet = append(personalInfoRet, info)
			}
		}
	} else {
		studentRet = studentDb
		personalInfoRet = personalInfoDb
	}
	start := offset * limit
	if start > len(studentRet)-1 {
		studentRet = nil
		personalInfoRet = nil
	}
	end := (offset + 1) * limit
	if end == 0 || (end > len(studentRet) && start < len(studentRet)) {
		end = len(studentRet)
	}

	fmt.Printf("name: %v, start: %v, end: %v\n", name, start, end)
	if studentRet != nil && personalInfoRet != nil {
		studentRet = studentRet[start:end]
		personalInfoRet = personalInfoRet[start:end]
	}

	type response struct {
		Student []Student
		PersonalInfo    []PersonalInfo
	}
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode(struct {
		Student []Student
		PersonalInfo    []PersonalInfo
	}{
		Student: studentRet,
		PersonalInfo:    personalInfoRet,
	})
}

func items(w http.ResponseWriter, req *http.Request) {
	w.Header().Set("Content-Type", "application/json")
	json.NewEncoder(w).Encode([]string{
		"Mo", "Uki", "Jungkook", "JK", "Ariana Grande", "Ariana Gomez", "Saoirse Ronan", "Timothee", "IU",
	})
}

func setUpDb() {
	for idx := 0; idx < 10; idx++ {
		copiedStudentSeed := make([]Student, len(studentSeed))
		copy(copiedStudentSeed, studentSeed)
		for i := range copiedStudentSeed {
			copiedStudentSeed[i].Name = copiedStudentSeed[i].Name + strconv.Itoa(idx)
		}
		copiedInfoSeed := make([]PersonalInfo, len(personalInfoSeed))
		copy(copiedInfoSeed, personalInfoSeed)
		for i := range copiedInfoSeed {
			copiedInfoSeed[i].Name = copiedInfoSeed[i].Name + strconv.Itoa(idx)
		}
		studentDb = append(studentDb, copiedStudentSeed...)
		personalInfoDb = append(personalInfoDb, copiedInfoSeed...)
	}
}

var startSecureMode bool

func init() {
	flag.BoolVar(&startSecureMode, "s", false, "start secure mode")
}
func main() {
	flag.Parse()
	setUpDb()
	http.HandleFunc("/students/info", manyItems)
	http.HandleFunc("/students", items)

	if len(os.Args) <= 1 {
		fmt.Println("Expected first arg to be a port number")
		os.Exit(1)
	}
	port := os.Args[1]
	if _, err := strconv.Atoi(port); err != nil {
		fmt.Printf("Expected first arg to be a port number but receive %v\n", port)
		os.Exit(1)
	}

	fmt.Printf("Heol~, u have a http server running on port %v\n", port)
	if startSecureMode {
		fmt.Println(`
	set up key and crt for https server
	# Key considerations for algorithm "RSA" ≥ 2048-bit
	openssl genrsa -out server.key 2048
	
	# Key considerations for algorithm "ECDSA" ≥ secp384r1
	# List ECDSA the supported curves (openssl ecparam -list_curves)
	openssl ecparam -genkey -name secp384r1 -out server.key
	openssl req -new -x509 -sha256 -key server.key -out server.crt -days 3650
	`)
		http.ListenAndServeTLS(":"+port, "server.crt", "server.key", nil)
	} else {
		fmt.Println(`running in insecure mode. To enable https, re-run with flag -s`)
		http.ListenAndServe(":"+port, nil)
	}

}
