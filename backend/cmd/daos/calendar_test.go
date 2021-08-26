package daos

import (
	"github.com/atedesch1/mebook/backend/cmd/config"
	"github.com/atedesch1/mebook/backend/cmd/test_data"
	"github.com/stretchr/testify/assert"
	"testing"
)

func TestCalendarDAO_Get(t *testing.T) {
	config.Config.DB = test_data.ResetDB()
	dao := NewCalendarDAO()

	calendar, err := dao.Get(3)

	expected := map[string]interface{}{"Title": "Work Calendar", "Time Zone": "BRT", "User ID": uint(1)}

	assert.Nil(t, err)
	assert.Equal(t, expected["Title"], calendar.Title)
	assert.Equal(t, expected["Time Zone"], calendar.TimeZone)
	assert.Equal(t, expected["User ID"], calendar.UserID)
}

func TestCalendarDAO_GetNotPresent(t *testing.T) {
	config.Config.DB = test_data.ResetDB()
	dao := NewCalendarDAO()

	calendar, err := dao.Get(9999)

	assert.NotNil(t, err)
	assert.Equal(t, "", calendar.Title)
	assert.Equal(t, "", calendar.TimeZone)
	assert.Equal(t, uint(0), calendar.UserID)
}
