import pandas as pd
import matplotlib.pyplot as plt
from pmdarima import auto_arima

# Загрузка данных
data = pd.read_csv('bitcoin_historical_data.csv')

# Преобразование столбца 'Timestamp' в тип datetime
data['Timestamp'] = pd.to_datetime(data['Timestamp'], unit='s')

# Использование столбца 'Timestamp' в качестве индекса
data.set_index('Timestamp', inplace=True)

# Создание временного ряда с частотой 1 минута
data.index = pd.date_range(start=data.index[0], periods=len(data), freq='T')

# Ресемплирование данных по месяцам и взятие последнего значения месяца
monthly_data = data.resample('M').last()

# Обучение и прогнозирование модели ARIMA для каждого столбца
forecasts = {}
for column in monthly_data.columns:
    # Обучение модели ARIMA
    model = auto_arima(monthly_data[column], seasonal=False, trace=True, error_action='ignore', suppress_warnings=True)
    fitted_model = model.fit(monthly_data[column])

    # Прогнозирование на будущее до 2025 года
    future_dates = pd.date_range(start=monthly_data.index[-1], periods=48, freq='M')[1:]  # Добавляем один месяц к последней дате
    forecast = fitted_model.predict(n_periods=len(future_dates))
    forecasts[column] = forecast

# Визуализация результатов
plt.figure(figsize=(12, 6))
for column, forecast in forecasts.items():
    plt.plot(monthly_data.index, monthly_data[column], label=column)
    plt.plot(future_dates, forecast, label=f'{column} Forecast', linestyle='--')
plt.title('Bitcoin Price Forecast until 2025 (Monthly)')
plt.xlabel('Date')
plt.ylabel('Price')
plt.legend()
plt.grid(True)
plt.show()