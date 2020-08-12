""" inspiration and the bulk of the program goes to Dr. Allen Downey
in his book, Think Python 2e"""

import random
import string
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import style
from collections import Counter

style.use('fivethirtyeight')


def process_file(filename):
    """Makes a histogram that contains the words from a file.
    filename: string
    returns: map from each word to the number of times it appears.
    """
    hist = {}
    fp = open(filename)

    for line in fp:
        process_line(line, hist)

    return hist


def process_line(line, hist):
    """Adds the words in the line to the histogram.
    Modifies hist.
    line: string
    hist: histogram (map from word to frequency)
    """
    # replace hyphens with spaces before splitting
    line = line.replace('-', ' ')
    strippables = string.punctuation + string.whitespace

    for word in line.split():
        # remove punctuation and convert to lowercase
        word = word.strip(strippables)
        word = word.lower()

        # update the histogram
        hist[word] = hist.get(word, 0) + 1


def most_common(hist):
    """
    Makes a counter of words and their frequencies, and prints
    the  10 most common
    """
    count = Counter(hist)
    for val, freq in count.most_common(10):
        print(val, freq)


def subtract(d1, d2):
    """Returns a dictionary with all keys that appear in d1 but not d2.
    d1, d2: dictionaries
    """
    res = {}
    for key in d1:
        if key not in d2:
            res[key] = None
    return res


def total_words(hist):
    """Returns the total of the frequencies in a histogram."""
    return sum(hist.values())


def financial_statements(file):
    """Prints the revenue statement, which is from lines 179 - 197 """
    with open(file) as f:
        for i, line in enumerate(f):
            if 179 < i < 197:
                print(line.strip())


def graph_hist():
    hist = process_file('Bear Stearns_10Q_2-29-2008.txt')
    hist_graph = []

    for i in hist:
        if hist[i] > 400:
            hist_graph.append((i, hist[i]))

    word = []
    frequency = []

    word, frequency = zip(*hist_graph)
    indices = np.arange(len(hist_graph))
    plt.bar(indices, frequency, color='b')
    plt.xticks(indices, word, rotation='vertical')
    plt.tight_layout()
    plt.show()


def main():
    hist = process_file('Bear Stearns_10Q_2-29-2008.txt')
    print('Total number of words:', total_words(hist))

    print('The most common words are:')
    most_common(hist)

    print("Here are the revenue figures from '08 - '07")
    financial_statements('Bear Stearns_10Q_2-29-2008.txt')

    print("And here's a graph of the most common words")
    graph_hist()

if __name__ == '__main__':
    main()
