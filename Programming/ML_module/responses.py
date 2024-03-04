import cv2
import utlis
import numpy as np

# --- LOADING THE IMAGE ---

image_path = "Images\Original\G146NFORC-064-Queestionari-dAvaluacio_page-0001.jpg"
width = 800
height = 1200
cropped_height = height//3
img = cv2.imread(image_path)
img = cv2.resize(img, (width, height))
img_roi = img[cropped_height: , :]
img_contours = img_roi.copy()
img_contours2 = img_roi.copy()


# --- IMAGE PROCESSING ---
img_gray = cv2.cvtColor(img_roi, cv2.COLOR_BGR2GRAY)
img_blur = cv2.GaussianBlur(img_gray, (5,5), 1)
img_canny = cv2.Canny(img_blur, 150, 180)

# --- CONTOURS DETECTION ---
contours, hierarchy = cv2.findContours(img_canny, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
cv2.drawContours(img_contours, contours, -1, (0,255,0), 3)

rectangles = utlis.rectContour(contours)

rectangles_arr = []
for rect in rectangles:
    rectangles_arr.append(utlis.getCornerPoints(rect))

corrected_rect = []
for rect in rectangles_arr:
    rect = utlis.reorder(rect)
    print (rect)
    pt1 = np.float32(rect)
    pt2 = np.float32(np.float32([[0,0],[width,0], [0,cropped_height],[width,cropped_height]]))
    matrix = cv2.getPerspectiveTransform(pt1, pt2)

    corrected_rect.append(cv2.warpPerspective(img_roi, matrix, (width, cropped_height)))

for rect in corrected_rect:
    cv2.imshow('rect', rect)
    cv2.waitKey(0)


for rect in rectangles:
    cv2.drawContours(img_contours2, [rect], -1, (0,255,0+len(rect)), 4)

image_array = ([img_roi, img_gray, img_blur, img_canny],
               [img_contours, img_contours2, np.zeros_like(img_roi), np.zeros_like(img_roi)])
img_stacked = utlis.stackImages(image_array, 0.5)

cv2.imshow("Stacked", img_stacked)
cv2.waitKey(0)
