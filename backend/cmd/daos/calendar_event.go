package daos

import (
	"github.com/atedesch1/mebook/backend/cmd/config"
	"github.com/atedesch1/mebook/backend/cmd/models"
)

// CalendarEventDAO persists calendarEvent data in database
type CalendarEventDAO struct{}

// NewCalendarEventDAO creates a new CalendarEventDAO
func NewCalendarEventDAO() *CalendarEventDAO {
	return &CalendarEventDAO{}
}

// Get does the actual query to database, if calendarEvent with specified id is not found error is returned
func (dao *CalendarEventDAO) Get(id uint) (*models.CalendarEvent, error) {
	var calendarEvent models.CalendarEvent

	// if using Gorm:
	err := config.Config.DB.Where("id = ?", id).
		First(&calendarEvent).
		Error

	return &calendarEvent, err
}
