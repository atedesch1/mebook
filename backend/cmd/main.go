package main

import (
	"context"
	"errors"
	"fmt"
	"net/http"
	"strings"

	"github.com/atedesch1/mebook/backend/cmd/apis"
	"github.com/atedesch1/mebook/backend/cmd/config"
	"github.com/atedesch1/mebook/backend/cmd/models"
	"github.com/atedesch1/mebook/backend/cmd/httputil"

	"firebase.google.com/go/auth"
	"firebase.google.com/go"
	"google.golang.org/api/option"

	"github.com/gin-gonic/gin"
	"github.com/jinzhu/gorm"
	_ "github.com/jinzhu/gorm/dialects/postgres"
	"log"

	swaggerFiles "github.com/swaggo/files"
	"github.com/swaggo/gin-swagger"


	_ "github.com/atedesch1/mebook/backend/cmd/docs"
)

// @title Blueprint Swagger API
// @version 1.0
// @description Swagger API for Golang Project Blueprint.
// @termsOfService http://swagger.io/terms/

// @contact.name API Support
// @contact.email martin7.heinz@gmail.com

// @license.name MIT
// @license.url https://github.com/atedesch1/mebook/backend/blob/master/LICENSE

// @BasePath /api/v1

// @securityDefinitions.apikey ApiKeyAuth
// @in header
// @name Authorization
func main() {
	// load application configurations
	if err := config.LoadConfig("./config"); err != nil {
		panic(fmt.Errorf("invalid application configuration: %s", err))
	}

	// Creates a router without any middleware by default
	r := gin.New()

	// Global middleware
	// Logger middleware will write the logs to gin.DefaultWriter even if you set with GIN_MODE=release.
	// By default gin.DefaultWriter = os.Stdout
	r.Use(gin.Logger())

	// Recovery middleware recovers from any panics and writes a 500 if there was one.
	r.Use(gin.Recovery())

	r.GET("/swagger/*any", ginSwagger.WrapHandler(swaggerFiles.Handler))

	ctx := context.Background()
	app, err := firebase.NewApp(ctx, nil, option.WithCredentialsJSON(config.Config.FirebaseCredentials))
	if err != nil {
		log.Fatalf("error initializing app: %v\n", err)
	}
	firebaseClient, err := app.Auth(ctx)
	if err != nil {
		log.Fatalf("error getting Auth client: %v\n", err)
	}


	v1 := r.Group("/api/v1")
	{
		v1.Use(authorize(firebaseClient))
		v1.GET("/users/:id", apis.GetUser)
		v1.GET("/health-check", apis.HealthCheck)
	}

	config.Config.DB, config.Config.DBErr = gorm.Open("postgres", config.Config.DSN)
	if config.Config.DBErr != nil {
		panic(config.Config.DBErr)
	}

	config.Config.DB.AutoMigrate(&models.User{}) // This is needed for generation of schema for postgres image.

	defer config.Config.DB.Close()

	log.Println("Successfully connected to database")

	r.Run(fmt.Sprintf(":%v", config.Config.ServerPort))
}

func authorize(firebaseClient *auth.Client) gin.HandlerFunc {
	return func(c *gin.Context) {
		authHeader := c.GetHeader("Authorization")
		jwtString := strings.Split(authHeader, "Bearer ")
		if len(jwtString) < 2 {
			httputil.NewError(c, http.StatusUnauthorized, errors.New("Authorization is required Header"))
			c.Abort()
			return
		}
		idToken := jwtString[1]

		token, err := firebaseClient.VerifyIDToken(c, idToken)
		if err != nil {
			httputil.NewError(c, http.StatusUnauthorized, errors.New("could not authenticate"))
			c.Abort()
			return
		}
		user, err := firebaseClient.GetUser(c, token.UID)
		if err != nil {
			httputil.NewError(c, http.StatusUnauthorized, errors.New("could not get user"))
			c.Abort()
			return
		}
		c.Set("email", user.Email)
		log.Printf("acess from %s", user.Email)
		c.Next()
	}
}
