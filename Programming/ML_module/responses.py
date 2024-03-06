import cv2
import utlis
import numpy as np


width = 800
height = 1200
cropped_height = height//3

global img_contours
global img_contours2

def load_image(path):
    global original
    img = cv2.imread(path)
    img = cv2.resize(img, (width, height))
    original = img[cropped_height: , :]
    return original


# --- IMAGE PROCESSING ---
def process_image(answers):
    global img_gray
    global img_blur
    global img_canny

    img_gray = cv2.cvtColor(answers, cv2.COLOR_BGR2GRAY)
    img_blur = cv2.GaussianBlur(img_gray, (5,5), 1)
    img_canny = cv2.Canny(img_blur, 150, 180)

    return img_canny

# --- CONTOURS DETECTION ---
def get_contours(answers):
    contours, hierarchy = cv2.findContours(answers, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_NONE)
    cv2.drawContours(img_contours, contours, -1, (0,255,0), 3)

    rectangles = utlis.rectContour(contours)

    rectangles_arr = []
    for rect in rectangles:
        rectangles_arr.append(utlis.getCornerPoints(rect))
    

    corrected_rect = []
    for rect in rectangles_arr:
        rect = utlis.reorder(rect)
        pt1 = np.float32(rect)
        pt2 = np.float32(np.float32([[0,0],[400,0], [0,cropped_height],[400,cropped_height]]))
        matrix = cv2.getPerspectiveTransform(pt1, pt2)

        corrected_rect.append(cv2.warpPerspective(original, matrix, (400, cropped_height)))

    for rect in corrected_rect:
        cv2.imshow('rect', rect)
        cv2.waitKey(0)


    for rect in rectangles:
        cv2.drawContours(img_contours2, [rect], -1, (0,255,0+len(rect)), 4)

    image_array = ([original, img_gray, img_blur, img_canny],
                [img_contours, img_contours2, np.zeros_like(answers), np.zeros_like(answers)])
    img_stacked = utlis.stackImages(image_array, 0.5)

    cv2.imshow("Stacked", img_stacked)
    cv2.waitKey(0)
        


if __name__ == "__main__":
    image_path = "Images\Original\G146NFORC-064-Queestionari-dAvaluacio_page-0001.jpg"

    answers = load_image(image_path)
    img_contours = answers.copy()
    img_contours2 = answers.copy()
    clear_answers = process_image(answers)
    get_contours(clear_answers)
