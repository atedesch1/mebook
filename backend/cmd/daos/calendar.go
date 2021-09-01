package daos

import (
	"github.com/atedesch1/mebook/backend/cmd/config"
	"github.com/atedesch1/mebook/backend/cmd/models"
)

// CalendarDAO persists calendar data in database
type CalendarDAO struct{}

// NewCalendarDAO creates a new CalendarDAO
func NewCalendarDAO() *CalendarDAO {
	return &CalendarDAO{}
}

// Get does the actual query to database, if calendar with specified id is not found error is returned
func (dao *CalendarDAO) Get(id uint) (*models.Calendar, error) {
	var calendar models.Calendar

	// if using Gorm:
	err := config.Config.DB.Where("id = ?", id).
		First(&calendar).
		Error

	return &calendar, err
}
