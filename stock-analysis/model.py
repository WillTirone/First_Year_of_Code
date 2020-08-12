import datetime as dt
from iexfinance import get_historical_data
from iexfinance import Stock
import matplotlib.pyplot as plt
from matplotlib import style
import pandas as pd
pd.core.common.is_list_like = pd.api.types.is_list_like
import pandas_datareader.data as web

style.use('ggplot')

# integrate this date into the historical function below
start = dt.datetime(2015, 1, 1)
end = dt.datetime.now()

# used to pull real time stock data
# stock data is then saved as a csv; this is not the most readable data but at least it works!
def CurrentData(ticker):
    try:
        equity = Stock('%s' % (ticker), output_format='pandas')
        df1 = equity.get_company() # gives basic company info like CEO, location, industry, etc.
        df2 = equity.get_earnings() # earnings per share (net income / shares outstanding) for past 4Q
        df3 = equity.get_financials() # basic financial metrics like revenue, gross profit, etc.
        df1.to_csv('company_info.csv')
        df2.to_csv('earnings.csv')
        df3.to_csv('financial_statements.csv')
    except ValueError:
        print('That ticker is not valid, choose another one!')

# used to pull historical data on a stock, then plots the close, open, and 100-day moving average
def HistoricalData(ticker):
    try:
        historical = get_historical_data('%s' % (ticker), start=start, end=end, output_format='pandas')
        historical['100ma'] = historical['close'].rolling(window=100).mean()
        historical[['close', 'open', '100ma']].plot()
        plt.xlabel('Date')
        plt.ylabel('$')
        plt.show()
    except:
        print('That ticker is not valid, choose another one!')

HistoricalData('AAPL')
CurrentData('AAPL')
