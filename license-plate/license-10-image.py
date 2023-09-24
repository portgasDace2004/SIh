import cv2

# Load the license plate cascade classifier
plate_cascade = cv2.CascadeClassifier("haarcascade_russian_plate_number.xml")

minArea = 500
count = 1  # Initialize a counter for saved images
max_images = 11  # Set the maximum number of images to capture

cap = cv2.VideoCapture(0)

while count < max_images:
    success, img = cap.read()
    imgGray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)  # Convert to grayscale
    number_plates = plate_cascade.detectMultiScale(imgGray, 1.1, 4)
    
    for (x, y, w, h) in number_plates:
        area = w * h
        if area > minArea:
            cv2.rectangle(img, (x, y), (x + w, y + h), (255, 0, 0), 2)
            cv2.putText(img, "NUMBER PLATE", (x, y - 5), cv2.FONT_HERSHEY_COMPLEX, 1, (0, 0, 255), 2)
            img_roi = img[y:y + h, x:x + w]
            
            # Save the detected license plate image
            cv2.imwrite(f"Output_Images/Images{count}.jpg", img_roi)
            count += 1

    cv2.imshow("RESULT", img)
    if cv2.waitKey(1) & 0xFF == ord('q'):
        break

cap.release()
cv2.destroyAllWindows()
