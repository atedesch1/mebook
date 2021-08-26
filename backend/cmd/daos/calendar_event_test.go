package daos

import (
	"github.com/atedesch1/mebook/backend/cmd/config"
	"github.com/atedesch1/mebook/backend/cmd/test_data"
	"github.com/stretchr/testify/assert"
	"testing"
	"time"
)

func TestCalendarEventDAO_Get(t *testing.T) {
	config.Config.DB = test_data.ResetDB()
	dao := NewCalendarEventDAO()

	calendarEvent, err := dao.Get(6)

	expected := map[string]interface{}{
		"Title": "Sprint Review",
		"Start Time": time.Date(2021, 2, 22, 22, 30, 30, 0, time.UTC),
		"End Time": time.Date(2021, 2, 22, 23, 30, 30, 0, time.UTC),
		"Calendar ID": uint(3),
	}

	assert.Nil(t, err)
	assert.Equal(t, expected["Title"], calendarEvent.Title)
	assert.Equal(t, expected["Start Time"], calendarEvent.StartTime)
	assert.Equal(t, expected["End Time"], calendarEvent.EndTime)
	assert.Equal(t, expected["Calendar ID"], calendarEvent.CalendarID)
}

func TestCalendarEventDAO_GetNotPresent(t *testing.T) {
	config.Config.DB = test_data.ResetDB()
	dao := NewCalendarEventDAO()

	calendarEvent, err := dao.Get(9999)

	assert.NotNil(t, err)
	assert.Equal(t, "", calendarEvent.Title)
	assert.Equal(t, time.Time{}, calendarEvent.StartTime)
	assert.Equal(t, time.Time{}, calendarEvent.EndTime)
	assert.Equal(t, uint(0), calendarEvent.CalendarID)
}
