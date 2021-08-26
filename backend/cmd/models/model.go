package models

import (
	"time"
)

// Model definition same as gorm.Model, but including column and json tags
type Model struct {
	ID        uint       `gorm:"primary_key;column:id" json:"id"`
	CreatedAt time.Time  `gorm:"column:created_at" json:"created_at"`
	UpdatedAt time.Time  `gorm:"column:updated_at" json:"updated_at"`
	DeletedAt *time.Time `gorm:"column:deleted_at" json:"deleted_at"`
}

// User Model
type User struct {
	Model
	FirstName string `gorm:"column:first_name" json:"first_name"`
	LastName  string `gorm:"column:last_name" json:"last_name"`
	Address   string `gorm:"column:address" json:"address"`
	Email     string `gorm:"column:email" json:"email"`
}

// Calendar Model
type Calendar struct {
	Model
	Title       string `gorm:"column:title" json:"title"`
	Description string `gorm:"column:description" json:"description"`
	TimeZone    string `gorm:"column:time_zone" json:"time_zone"`
	UserID      uint   `gorm:"column:user_id" json:"user_id"`
	User        User   `gorm:"constraint:OnDelete:CASCADE"`
}

// CalendarEvent Model
type CalendarEvent struct {
	Model
	Title      string    `gorm:"column:title" json:"title"`
	StartTime  time.Time `gorm:"column:start_time" json:"start_time"`
	EndTime    time.Time `gorm:"column:end_time" json:"end_time"`
	MeetLink   string    `gorm:"column:meet_link" json:"meet_link"`
	CalendarID uint      `gorm:"column:calendar_id" json:"calendar_id"`
	Calendar   Calendar  `gorm:"constraint:OnDelete:CASCADE"`
}
