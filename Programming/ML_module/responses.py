import os
import sys
import cv2
import utlis
import numpy as np


width = 800
height = 1200
cropped_height = height//3
possible_answers = [3, 10, 3, 1, 1, 6, 6, 3, 3, 5]
#possible_answers = [0, 1, 2, 10, 3, 1, 1, 6, 6, 3, 3, 5] #Position 0 not used. Question 8 2 possible answers

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
    contours, hierarchy = cv2.findContours(answers, cv2.RETR_EXTERNAL, cv2.CHAIN_APPROX_SIMPLE)
    cv2.drawContours(img_contours, contours, -1, (0,255,0), 3)

    rectangles = utlis.rectContour(contours)
    return rectangles

def answers_corners(rectangles):
    rectangles_arr = []
    for rect in rectangles:
        rectangles_arr.append(utlis.getCornerPoints(rect))

    rectangles_arr = utlis.divide_and_sort_rectangles(rectangles_arr)

    return rectangles_arr

def correct_rectangles(rectangles):
    corrected_rect = []
    for rect in rectangles:
        rect = utlis.reshape(rect)
        pt1 = np.float32(rect)
        pt2 = np.float32(np.float32([[0,0],[400,0], [0,cropped_height],[400,cropped_height]]))
        matrix = cv2.getPerspectiveTransform(pt1, pt2)

        corrected_rect.append(cv2.warpPerspective(original, matrix, (400, cropped_height)))

    for rect in rectangles:
        cv2.drawContours(img_contours2, [rect], -1, (0,255,0+len(rect)), 4)

    image_array = ([original, img_gray, img_blur, img_canny],
                [img_contours, img_contours2, np.zeros_like(answers), np.zeros_like(answers)])
    img_stacked = utlis.stackImages(image_array, 0.5)

    #cv2.imshow("Stacked", img_stacked)
    #cv2.waitKey(0)
    return corrected_rect

def threshold_answers(rectangles):
    answers = []
    for rectangle in rectangles:
        img_warp_gray = cv2.cvtColor(rectangle, cv2.COLOR_BGR2GRAY)
        img_thresh = cv2.threshold(img_warp_gray, 180, 255,cv2.THRESH_BINARY_INV)[1]
        #cv2.imshow("Stacked", img_thresh)
        #cv2.waitKey(0)
        answers.append(img_thresh)
    return answers


def get_answer(rectangles):
    for i, rect in enumerate(rectangles):
        _, thresh = cv2.threshold(rect, 120, 255, cv2.THRESH_BINARY_INV)
        contours, hierarchy = cv2.findContours(thresh, cv2.RETR_TREE, cv2.CHAIN_APPROX_SIMPLE)

        color_rect = cv2.cvtColor(rect, cv2.COLOR_GRAY2BGR)
        
        #Show colors for inner and outer contours
        for j, (contour, h) in enumerate(zip(contours, hierarchy[0])):
            color = (0, 255, 0) if h[3] == -1 else (0, 0, 255)  #Green => Exterior, Red => Interior
            cv2.drawContours(color_rect, [contour], -1, color, 3)

        #cv2.imshow('Rect'+str(i), color_rect)
        #cv2.waitKey(0)#

def count_pixels(answer, options, image_index, folder_name):
    if options == 1:
        folder_path = os.path.join("human_check", folder_name)
        if not os.path.exists(folder_path):
            os.makedirs(folder_path)  # Crear la carpeta si no existe
        filename = f"answer_{image_index}_{folder_name}.png"
        filepath = os.path.join(folder_path, filename)
        cv2.imwrite(filepath, answer)
        print("Image saved as:", filepath)
    
    parts = utlis.separe_answers(answer, options)
    
    answer_pixels = []
    for part in parts:
        white_pixels = utlis.max_pixels(part)
        #print("white pixels: ", white_pixels)
        answer_pixels.append(white_pixels)

    max_pixels = max(answer_pixels)
    second_max_pixels = sorted(answer_pixels, reverse=True)[1] if len(answer_pixels) > 1 else 0

    if second_max_pixels > 0 and (max_pixels - second_max_pixels) / max_pixels < 0.25:
        #print("Difference between first and second answer less than 25%, returning 0")
        return 0
    
    print ("ANSWER: " + str(answer_pixels.index(max(answer_pixels)) + 1))
    return answer_pixels.index(max(answer_pixels)) + 1


if __name__ == "__main__":
    folder_path = sys.argv[1]
    username = sys.argv[2]
    
    image_files = os.listdir(folder_path)

    for image_file in image_files:
        # Construct the full path to the image
        image_path = os.path.join(folder_path, image_file)
        
        # Load the image
        answers = load_image(image_path)
        img_contours = answers.copy()
        img_contours2 = answers.copy()
        clear_answers = process_image(answers)
        
        contours = get_contours(clear_answers)
        corners = answers_corners(contours)
        corners = correct_rectangles(corners)
        answers = threshold_answers(corners)
        
        # Iterate over each question and answer in the current image
        for i, answer in enumerate(answers):
            print("Analyzing image:", image_file)
            print("Seeing Question:", i+2)
            answers = count_pixels(answer, possible_answers[i], i, username)