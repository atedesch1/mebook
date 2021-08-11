package apis

import (
	"github.com/atedesch1/mebook/cmd/test_data"
	"net/http"
	"testing"
)

func TestUser(t *testing.T) {
	path := test_data.GetTestCaseFolder()
	runAPITests(t, []apiTestCase{
		{"t1 - get a User", "GET", "/users/:id", "/users/1", "", GetUser, http.StatusOK, path + "/user_t1.json"},
		{"t2 - get a User not Present", "GET", "/users/:id", "/users/9999", "", GetUser, http.StatusNotFound, ""},
	})
}
