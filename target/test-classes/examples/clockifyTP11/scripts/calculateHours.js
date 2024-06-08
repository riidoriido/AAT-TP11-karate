function calculateHours(start,end){
// Define the date strings
const date1 = start;
const date2 = end;

// Parse the date strings into Date objects
const startDate = new Date(date1);
const endDate = new Date(date2);

// Calculate the difference in milliseconds
const diffInMilliseconds = endDate - startDate;

// Convert the difference from milliseconds to hours
const hoursAmount = diffInMilliseconds / (1000 * 60 * 60);

return hoursAmount;
}