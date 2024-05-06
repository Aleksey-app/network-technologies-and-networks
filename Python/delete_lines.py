def delete_lines(filename):
    # Читаем содержимое файла
    with open(filename, 'r') as file:
        lines = file.readlines()

    # Открываем файл для записи
    with open(filename, 'w') as file:
        # Записываем строки, пропуская каждую вторую, четвертую и так далее
        for i, line in enumerate(lines):
            if (i + 1) % 2 != 0:
                file.write(line)

filename = 'example.txt'  # Замените 'example.txt' на имя вашего файла
delete_lines(filename)
