import os
from docx import Document

def find_text_in_docx(directory, text_to_find):
    found_in_files = []

    for root, dirs, files in os.walk(directory):
        for file in files:
            if file.endswith('.docx'):
                file_path = os.path.join(root, file)
                doc = Document(file_path)
                for paragraph in doc.paragraphs:
                    if text_to_find in paragraph.text:
                        found_in_files.append(file_path)
                        break

    return found_in_files

if __name__ == "__main__":
    directory = input("Введите путь к каталогу для поиска: ")
    text_to_find = input("Введите текст для поиска: ")

    found_files = find_text_in_docx(directory, text_to_find)

    if found_files:
        print("Найдено в следующих файлах:")
        for file in found_files:
            print(file)
    else:
        print("Текст не найден в файлах DOCX.")
