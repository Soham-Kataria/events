// constants/dbConstants.js

// Collection names
const COLLECTIONS = {
  USERS: 'users',
  EVENTS: 'events',
  BOOKINGS: 'bookings',
  PAYMENTS: 'payments',
  REVIEWS: 'reviews',
  NOTIFICATIONS: 'notifications',
  CATEGORIES: 'categories', // Optional: event categories
  VENUES: 'venues'           // Optional: venue info
};

// User roles
const USER_ROLES = {
  ADMIN: 'admin',
  ORGANIZER: 'organizer',
  USER: 'user',
  GUEST: 'guest' // Optional: non-logged-in users
};

// Booking status
const BOOKING_STATUS = {
  PENDING: 'pending',
  CONFIRMED: 'confirmed',
  CANCELLED: 'cancelled',
  REFUNDED: 'refunded'
};

// Payment status
const PAYMENT_STATUS = {
  SUCCESS: 'success',
  FAILED: 'failed',
  PENDING: 'pending',
  REFUNDED: 'refunded'
};

// Notification types
const NOTIFICATION_TYPES = {
  EVENT_UPDATE: 'event_update',
  PROMOTION: 'promotion',
  REMINDER: 'reminder',
  SYSTEM: 'system'
};

// Event status and visibility
const EVENT_STATUS = {
  UPCOMING: 'upcoming',
  ONGOING: 'ongoing',
  COMPLETED: 'completed',
  CANCELLED: 'cancelled'
};

const EVENT_VISIBILITY = {
  PUBLIC: 'public',
  PRIVATE: 'private'
};

// Review / rating constants
const REVIEW_RATING = {
  MIN: 1,
  MAX: 5
};

// General response messages
const RESPONSE_MESSAGES = {
  SUCCESS: 'Operation successful',
  ERROR: 'Something went wrong',
  NOT_FOUND: 'Resource not found',
  UNAUTHORIZED: 'Unauthorized access'
};

module.exports = {
  COLLECTIONS,
  USER_ROLES,
  BOOKING_STATUS,
  PAYMENT_STATUS,
  NOTIFICATION_TYPES,
  EVENT_STATUS,
  EVENT_VISIBILITY,
  REVIEW_RATING,
  RESPONSE_MESSAGES
};
