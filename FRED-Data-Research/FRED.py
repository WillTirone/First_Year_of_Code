import pandas as pd
import quandl
import matplotlib.pyplot as plt
from matplotlib import style
style.use('fivethirtyeight')

# sources below are using Quandl from the Federal Reserve Economic Data ('FRED')

df1 = quandl.get("FRED/UNEMPLOY", authtoken="###") # nominal rate of unemployment
df2 = quandl.get("FRED/GDP", authtoken="###") # GDP
df3 = quandl.get("FRED/HOUST", authtoken="###") # New Privately Owned Housing Units Started

# the '08 recession was technically Dec. 2007 - June 2009, though I'm including data from '06 onwards
U = df1.loc['2006-1-1':'2013-12-31']
G = df2.loc['2006-1-1':'2013-12-31']
H = df3.loc['2006-1-1':'2013-12-31']

joined_data1 = pd.merge(pd.merge(U, G, left_index=True, right_index=True), H, left_index=True, right_index=True)
joined_data1.columns = ['Unemployment', 'GDP', 'New Housing']

print(joined_data1)

plt.plot(df1)
plt.plot(df2)
plt.plot(df3)

plt.show()
