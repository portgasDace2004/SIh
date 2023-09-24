import cv2
import numpy as np
import easyocr
import firebase_admin
from firebase_admin import credentials
from firebase_admin import db

# Image Read
img = cv2.imread('image3.jpg')
gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

# More Filters
bfilter = cv2.bilateralFilter(gray, 11, 17, 17)  # Noise reduction
edged = cv2.Canny(bfilter, 30, 200)  # Edge detection

keypoints = cv2.findContours(edged.copy(), cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)
contours = sorted(keypoints[0], key=cv2.contourArea, reverse=True)[:10]

location = None
for contour in contours:
    approx = cv2.approxPolyDP(contour, 10, True)
    if len(approx) == 4:
        location = approx
        break

mask = np.zeros(gray.shape, np.uint8)
new_image = cv2.drawContours(mask, [location], 0, 255, -1)
new_image = cv2.bitwise_and(img, img, mask=mask)

(x, y) = np.where(mask == 255)
(x1, y1) = (np.min(x), np.min(y))
(x2, y2) = (np.max(x), np.max(y))
cropped_image = gray[x1:x2 + 1, y1:y2 + 1]

# Use EasyOCR to read the text from the cropped image
reader = easyocr.Reader(['en'])
result = reader.readtext(cropped_image)

if result:
    license_plate_text = result[0][-2]
    # print("License Plate Text:", license_plate_text)
    print(license_plate_text)
else:
    print("License plate text not found.")



# Initialize the Firebase Admin SDK with your service account credentials and database URL
cred = credentials.Certificate("street-park-5fda5-firebase-adminsdk-s5u6f-ade62fa97e.json")
firebase_admin.initialize_app(cred, {
    "databaseURL": "https://street-park-5fda5-default-rtdb.asia-southeast1.firebasedatabase.app/"
})

# Get a reference to the database
ref = db.reference("/")

# Push data to the database
data = {
    "License-Plate-Number": license_plate_text,
}

ref.child("Data").push(data)

# Close Firebase Admin SDK (optional)
firebase_admin.delete_app(firebase_admin.get_app())

