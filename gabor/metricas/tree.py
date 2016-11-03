import numpy as np
import matplotlib.pyplot as plt
import os

from sklearn.datasets import make_classification
from sklearn.ensemble import ExtraTreesClassifier
from sklearn.datasets import load_svmlight_file
from sklearn.datasets import dump_svmlight_file

path = "/media/eucassio/dados/facedatabase/vetores de caracteristicas ARFACE/"

for files in os.listdir(path):
    if files.endswith(".txt"):
        print files
        X1, y1 = load_svmlight_file(path + files)

        numSplit = 4
        sizeSplit = X1.shape[1] / numSplit
        print numSplit
        xFeatures = np.array([])
        for g in range(numSplit):
            print ("[%d, %d[" % (sizeSplit * g, sizeSplit*(g+1)))
         
            #y = y1[0:y1.shape[0],(sizeSplit * g):sizeSplit*(g+1)]
            y = y1
            X = X1[0:y1.shape[0],(sizeSplit * g):sizeSplit*(g+1)]
        
            print X1.shape
            
            # Build a forest and compute the feature importances
            forest = ExtraTreesClassifier(n_estimators=250, random_state=0, n_jobs=3)
            
            forest.fit(X, y)
            importances = forest.feature_importances_
            std = np.std([tree.feature_importances_ for tree in forest.estimators_],
                         axis=0)
            indices = np.argsort(importances)[::-1]
            
            # Print the feature ranking
            #print("Feature ranking:")
            
            i = 0
            indicesFeatures = []
            for f in range(X.shape[1]):
                if(f < 1500):
                    indicesFeatures.append(indices[f])
                    #print("%d. feature %d (%f)" % (f + 1, indices[f], importances[indices[f]]))
            
            xFeatures = X[:,indicesFeatures]
            print xFeatures.shape
     
            #if(xFeatures.shape[0] == 0 ):
            #   xFeatures =  xFeaturesTmp
            #else:
    
            
            print "----------------"   
            dump_svmlight_file(xFeatures, y, path + files[:-4] +"_" + str(g) +"_sub.txt")
        # Plot the feature importances of the forest
        #plt.figure()
        #plt.title("Feature importances")
        #plt.bar(range(xFeatures.shape[1]), importances[indicesFeatures],
        #       color="r", yerr=std[indicesFeatures], align="center")
        #plt.xticks(range(xFeatures.shape[1]), indices)
        #plt.xlim([-1, xFeatures.shape[1]])
        #plt.show()
print "fim"        
