from math import floor
import numpy
import os
import re
import sys

from sklearn.model_selection import cross_validate
from sklearn import metrics
from sklearn import svm
from sklearn.cross_validation import train_test_split
from sklearn.datasets import dump_svmlight_file
from sklearn.datasets import load_iris
from sklearn.datasets import load_svmlight_file
from sklearn.datasets import load_svmlight_file
from sklearn.datasets import make_classification
from sklearn.ensemble import RandomForestClassifier
from sklearn.metrics import confusion_matrix
from sklearn.metrics import f1_score
from sklearn.metrics import precision_score
from sklearn.metrics import recall_score

import matplotlib.pyplot as plt
import numpy as np
from serial.tools.list_ports_common import numsplit

X1 =0
path = "/media/eucassio/dados/facedatabase/vetores_extras/wild_recortada_manualmente/random_forest/"
indicesOne = []

def classificar(files, vetor, y_train, f, numFeatures, numsplit):
    crossV = int(re.findall('[0-9]+', files)[-11])

    X_train = vetor# svm classification

    clf = svm.SVC(kernel='rbf', gamma=0.000030517578125, C=8.0)
    print 'Tam vetor = ' + str(X_train.shape[1])
    print 'Cross = ' + str(crossV)
    sizeFeatures = X_train.shape[1]

    predicted = cross_validation.cross_val_predict(clf, X_train, y_train, cv=crossV, n_jobs=3)
    #precisaomacro = precision_score(y_train, predicted, average='macro')
    #precisaomicro = precision_score(y_train, predicted, average='micro')
    #precisaoweighted = precision_score(y_train, predicted, average='weighted')
    acuracia = metrics.accuracy_score(y_train, predicted)
    #con = confusion_matrix(y_train, predicted)
    #f1Scoremacro = f1_score(y_train, predicted, average='macro')
    #f1Scoremicro = f1_score(y_train, predicted, average='micro')
    #f1Scoreweighted = f1_score(y_train, predicted, average='weighted')
    #recallmacro = recall_score(y_train, predicted, average='macro')
    #recallmicro = recall_score(y_train, predicted, average='micro')
    #recallweighted = recall_score(y_train, predicted, average='weighted')

    f = open("/media/eucassio/dados/facedatabase/vetores_extras/wild_recortada_manualmente/random_forest/resultado_comn_estimators250_sem_dividir_3800.csv", 'a')
    f.write(files + ";" + str(sizeFeatures) + ";" + str(acuracia) + ";" + str(numFeatures) + ";" + str(numsplit) +"\n")
    f.close()
    #f = open(path + files[:-4] + "_resultados.txt", 'wb')
    #f.write('tamanho do vetor de caracteristicas: ' + '{}'.format(sizeFeatures) + '\n')
    #f.write('precisao    macro: ' + '{}'.format(precisaomacro) + '\n')
    #f.write('precisao    micro: ' + '{}'.format(precisaomicro) + '\n')
    #f.write('precisao weighted: ' + '{}'.format(precisaoweighted) + '\n')
    #f.write('acuracia: ' + '{}'.format(acuracia) + '\n')
    #f.write('f1Score    macro: ' + '{}'.format(f1Scoremacro) + '\n')
    #f.write('f1Score    micro: ' + '{}'.format(f1Scoremicro) + '\n')
    #f.write('f1Score weighted: ' + '{}'.format(f1Scoreweighted) + '\n')
    #f.write('recall    macro: ' + '{}'.format(recallmacro) + '\n')
    #f.write('recall    micro: ' + '{}'.format(recallmicro) + '\n')
    #f.write('recall weighted: ' + '{}'.format(recallweighted) + '\n')
    #numpy.savetxt(f, con, fmt="%s")
    #f.close()

def selecao(numFeatures, numSplit, X1,y1,indicesOne):
    print 'num fetures por bloco ' + str(numFeatures)
    print 'Num blocos '+ str(numSplit)


    #numFeatures = 375

    #for files in os.listdir(path):
        #if files.endswith("hist_gabor_curvo_WILD_TODAS_IMAGENS_CORTADAS_REDIMENSIONADAS_CINZA_0_84_6_4x4_5x16_15x15_concatenado_3_6000_sub_concatenado.txt"):
    featuresFull = None
    #print 'carregando arquivo: ' + files


    #print 'lido'
    #numSplit = 4
    sizeSplit = X1.shape[1] / numSplit
    sizeSplit=floor(sizeSplit)
    xFeatures = np.array([])

    for g in range(numSplit):
        #print ("[%d, %d[" % (sizeSplit * g, sizeSplit*(g+1)))

        #y = y1[0:y1.shape[0],(sizeSplit * g):sizeSplit*(g+1)]
        y = y1
        X = X1[0:y1.shape[0],(sizeSplit * g):sizeSplit*(g+1)]

        #print X1.shape

        # Build a forest and compute the feature importances
        if(len(indicesOne) == 0 and numSplit == 1):
            forest = RandomForestClassifier(n_estimators=250, random_state=0, n_jobs=3)
            forest.fit(X, y)
            importances = forest.feature_importances_
            std = np.std([tree.feature_importances_ for tree in forest.estimators_], axis=0)
            indices = np.argsort(importances)[::-1]
            indicesOne = indices
        else:
            indices = indicesOne

        # Print the feature ranking
        #print("Feature ranking:")

        i = 0
        indicesFeatures = []
        for f in range(X.shape[1]):
            if(f < numFeatures):
                indicesFeatures.append(indices[f])
                #print("%d. feature %d (%f)" % (f + 1, indices[f], importances[indices[f]]))
                #writer= open("/media/eucassio/dados/facedatabase/vetores_extras/wild_recortada_manualmente/random_forest/features_detail_semdividir.csv", 'a')
                #writer.write(str(numFeatures) + ";" + str(numSplit) + ";" + str(sizeSplit * g) + ";" + str(sizeSplit*(g+1)) +  ";" + str(indices[f]) + ";" + str(importances[indices[f]]) +"\n")
                #writer.close()

        xFeatures = X[:,indicesFeatures]
        #print xFeatures.shape

        #if(xFeatures.shape[0] == 0 ):
        #   xFeatures =  xFeaturesTmp
        #else:
        #print 'dimensoes'
        #print(xFeatures.shape)
        #if(featuresFull != None):
        #    print featuresFull.shape
        #print "----------------"
        if(featuresFull == None):
            featuresFull = xFeatures
        else:
            featuresFull = np.hstack((featuresFull,xFeatures))
            #np.concatenate((featuresFull,xFeatures),axis=1)
            #featuresFull.append(xFeatures,axis=1)

        #print(featuresFull.shape)

    #print(featuresFull.shape)
    classificar('WILD_22112016_REDIMENSIONADA__0_100_6_4x4_5x8_15x15__concatenado_0_3800_sub_3800x1_fore.txt', featuresFull, y1, f, numFeatures, numSplit)
    return indicesOne
    #dump_svmlight_file(featuresFull, y, path + files[:-4] +"_" + str(g) +"_" + str(numFeatures*numSplit) +"_sub0000.txt")
    # Plot the feature importances of the forest
    #plt.figure()
    #plt.title("Feature importances")
    #plt.bar(range(xFeatures.shape[1]), importances[indicesFeatures],
    #       color="r", yerr=std[indicesFeatures], align="center")
    #plt.xticks(range(xFeatures.shape[1]), indices)
    #plt.xlim([-1, xFeatures.shape[1]])
    #plt.show()



c=0
X1, y1 = load_svmlight_file(path + 'WILD_22112016_REDIMENSIONADA__0_100_6_4x4_5x8_15x15__concatenado_0_3800_sub_3800x1_forest.txt')
X1 = X1.toarray()
print X1.shape[1]
print X1.shape[1]/100

#for i in range(2,X1.shape[1]/100):
for i in range(1,2):
        if X1.shape[1] % i == 0:
            for j in range (100,(X1.shape[1]/i),50):
                if( i * j <= 10000 and i * j >= 400):
                    c  = c+1
                    print str(c) + " de 193 : " + str(i) + "," +str(j) + " = " + str(i*j)
                    indicesOne = selecao(j,i,X1,y1,indicesOne)
print c
numFeatures = sys.argv[1]
numFeatures = int(numFeatures)


numSplit = sys.argv[2]
numSplit = int(numSplit)
#path = sys.argv[2]
