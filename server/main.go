package main

import (
	"context"
	"fmt"
	"log"
	"os"

	firebase "firebase.google.com/go/v4"
	messaging "firebase.google.com/go/v4/messaging"
	"google.golang.org/api/option"
)

const (
	EventNotifyChallengeJoined = "challenge.joined"
	EventNotifyChallengeRecord = "challenge.newrecord"
)

func userJoined(challengeUUID string, challengeName string, displayName string) *messaging.Message {
	return &messaging.Message{
		Notification: &messaging.Notification{
			Title: fmt.Sprintf("%s joined %s", displayName, challengeName),
			//Body:  fmt.Sprintf("%s joined %s", displayName, challengeName),
		},
		Data: map[string]string{
			"uuid":   challengeUUID,
			"who":    displayName,
			"name":   challengeName,
			"action": EventNotifyChallengeJoined,
		},
	}
}

func recordAdded(challengeUUID string, challengeName string, displayName string) *messaging.Message {
	return &messaging.Message{
		Notification: &messaging.Notification{
			Title: fmt.Sprintf("%s added a plank to %s", displayName, challengeName),
		},
		Data: map[string]string{
			"uuid":   challengeUUID,
			"who":    displayName,
			"name":   challengeName,
			"action": EventNotifyChallengeRecord,
		},
	}

}

func main() {
	// devPush
	registrationToken := os.Getenv("TOKEN")
	if registrationToken == "" {
		fmt.Println("TOKEN now set")
		return
	}

	opt := option.WithCredentialsFile("/Users/tinkerbell/Downloads/freshteapot.net_api-project-922982262824-firebase-adminsdk-5wofg-8a5ca7a592.json")
	app, err := firebase.NewApp(context.Background(), nil, opt)
	if err != nil {
		log.Fatalf("error initializing app: %v\n", err)
	}

	ctx := context.Background()
	client, err := app.Messaging(ctx)
	if err != nil {
		log.Fatalf("error getting Messaging client: %v\n", err)
	}

	// This registration token comes from the client FCM SDKs.

	challengeUUID := "34b24213-f1e9-412d-a4b5-079f2b1b9029"
	challengeName := "Join Tine Rehab"
	displayName := "Tine"

	message := userJoined(challengeUUID, challengeName, displayName)
	//message := recordAdded(challengeUUID, challengeName, displayName)
	message.Token = registrationToken

	// Send a message to the device corresponding to the provided
	// registration token.
	response, err := client.Send(ctx, message)
	if err != nil {
		log.Fatalln(err)
	}
	// Response is a message ID string.
	fmt.Println("Successfully sent message:", response)
}
