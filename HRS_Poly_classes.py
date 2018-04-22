import sys
sys.path.append('/usr/local/lib/python3.6/site-packages')

from keras.models import Sequential
from keras.layers import Dense
import numpy as np
import pandas as pd
from sklearn.model_selection import train_test_split
from scipy import stats
from keras.utils import to_categorical
from sklearn.model_selection import GridSearchCV
from keras.wrappers.scikit_learn import KerasClassifier
from keras.optimizers import SGD
from sklearn.model_selection import cross_val_score
from sklearn.model_selection import KFold
from sklearn.preprocessing import LabelEncoder
from sklearn.pipeline import Pipeline
from sklearn.utils import class_weight as CW
import matplotlib.pyplot as pyplot
import pdb
from precision_recall import *
from sklearn.metrics import recall_score
from imblearn.over_sampling import SMOTE


np.random.seed(7)

"""This is a neural net with various parameters commented out. It provides AUC for prediction of a 2-level outcome"""

class NN:

    def __init__(self):
        self.X = None
        self.y = None

    def init_data(self):
        dataset = pd.read_csv("/Users/isaac/HRS/HRS_Poly_Classes.csv", delimiter=',', skiprows=0)
        #tempX = dataset.iloc[:, 1:13]
        tempX = dataset[['PC1_5A', 'PC1_5B','PC1_5C','PC1_5D', 'PC1_5E', 'PGS_depsymp_SSGAC16']]
        tempY = dataset[['emergent depression']]
        #tempY = dataset.iloc[:, 16]
        #pdb.set_trace()
        sm = SMOTE(random_state=12, ratio=1.0)
        X, Y = sm.fit_sample(tempX, tempY)
        self.X = np.asmatrix(stats.zscore(X, axis=0, ddof=1))
        encoder = LabelEncoder()
        encoder.fit(Y)
        encoded_Y = encoder.transform(Y)
        self.y = to_categorical(encoded_Y)
        pass


    #pdb.set_trace()

    def create_model(self, activation='softmax'):
        model = Sequential()
        model.add(Dense(6, input_dim=6, kernel_initializer='uniform', activation='relu'))
        model.add(Dense(2, kernel_initializer='uniform',  activation=activation))
        #optimizer = SGD(lr=learn_rate, momentum=momentum)
        model.compile(loss='categorical_crossentropy', optimizer='adam', metrics=['acc', precision, recall])
        return model



        #history = model.fit(self.X, self.y, epochs=400, batch_size=len(self.X), verbose=2)
        #y_pred = model.predict_classes(self.X, verbose=1)
        #pyplot.plot(history.history['acc'])
        #pyplot.show()
        #posPV = ppv(Y, y_pred)


    def fit(self, model, c_m):
        #class_weight = CW.compute_class_weight('balanced', np.unique(self.y[0]), self.y[0])
        model = KerasClassifier(build_fn=c_m, epochs=200, batch_size=10,  verbose=0) #class_weight = class_weight,
        # optimizer = ['SGD', 'RMSprop', 'Adagrad', 'Adadelta', 'Adam', 'Adamax', 'Nadam']
        # batch_size = [100]
        # epochs = [50]
        # learn_rate = [0.001]
        # activation = ['softmax', 'softplus', 'softsign', 'relu', 'tanh', 'sigmoid', 'hard_sigmoid', 'linear']
        # momentum = [0.0, 0.2, 0.4, 0.6, 0.8, 0.9]
        # init_mode = ['uniform', 'lecun_uniform', 'normal', 'zero', 'glorot_normal', 'glorot_uniform', 'he_normal',
        #             'he_uniform']
        kfold = KFold(n_splits=10, shuffle=True, random_state=1234)
        neurons = [1, 5, 10, 15, 20, 25, 30]
       #
        #param_grid = dict(neurons=neurons)
        #grid = GridSearchCV(estimator=model, param_grid=param_grid, n_jobs=-1)
        #grid_result = grid.fit(self.X, self.y)
        results = cross_val_score(model, self.X, self.y, cv=kfold)
        model.fit(self.X, self.y)
        y_pred = model.predict(self.X, batch_size=128, verbose=1)
       # pdb.set_trace()
       # y_pred = model.predict_classes(self.X, verbose=1)
        #y_pred = cross_val_score.score
        #y_true = self.y
        print("Baseline: %.2f%% (%.2f%%)" % (results.mean() * 100, results.std() * 100))
        print(y_pred)
        return y_pred

    #def results(self, grid_result):
     #   print("Best: %f using %s" % (grid_result.best_score_, grid_result.best_params_))
      #  means = grid_result.cv_results_['mean_test_score']
       # stds = grid_result.cv_results_['std_test_score']
       # params = grid_result.cv_results_['params']
       # for mean, stdev, param in zip(means, stds, params):
       #     print("%f (%f) with: %r" % (mean, stdev, param))

def main():
    nn = NN()
    nn.init_data()
    #precision = nn.precision(y_p)
    #recall = nn.recall()
    model = nn.create_model()
    nn.fit(model, nn.create_model)
    #nn.results(grid_results)

if __name__ == "__main__":
    main()

