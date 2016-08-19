from sklearn import svm
from sklearn import metrics
from sklearn.cross_validation import train_test_split
from sklearn import cross_validation
from sklearn.datasets import load_iris
from sklearn.metrics import precision_score
from sklearn.metrics import f1_score
from sklearn.metrics import recall_score
from sklearn.datasets import load_svmlight_file
from sklearn.metrics import confusion_matrix
import pickle
import numpy

X_train, y_train = load_svmlight_file("/home/eucassio/mestrado/face-recognition/gabor/resultados/processados/03072016/filtro_gabor_curvo_entropia_2pi_ARface_48_56_iluminacao_0_100_6_4x4_5x8_15x15_.txt")


# svm classification
clf = svm.SVC(kernel='rbf', gamma=0.000030517578125, C = 8.0)

predicted = cross_validation.cross_val_predict(clf, X_train,y_train, cv=6)

precisaomacro = precision_score(y_train, predicted, average='macro')  
precisaomicro = precision_score(y_train, predicted, average='micro')  
precisaoweighted = precision_score(y_train, predicted, average='weighted')  

acuracia = metrics.accuracy_score(y_train, predicted)  
con = confusion_matrix(y_train, predicted)

f1Scoremacro = f1_score(y_train, predicted, average='macro')
f1Scoremicro = f1_score(y_train, predicted, average='micro')  
f1Scoreweighted = f1_score(y_train, predicted, average='weighted')  


recallmacro = recall_score(y_train, predicted, average='macro')  
recallmicro = recall_score(y_train, predicted, average='micro')
recallweighted = recall_score(y_train, predicted, average='weighted')

f = open('resultados.txt','wb')

f.write('precisao    macro: ' + '{}'.format(precisaomacro)+'\n')
f.write('precisao    micro: ' + '{}'.format(precisaomicro)+'\n')
f.write('precisao weighted: ' + '{}'.format(precisaoweighted)+'\n')

f.write('acuracia: ' + '{}'.format(acuracia)+'\n')

f.write('f1Score    macro: ' + '{}'.format(f1Scoremacro)+'\n')
f.write('f1Score    micro: ' + '{}'.format(f1Scoremicro)+'\n')
f.write('f1Score weighted: ' + '{}'.format(f1Scoreweighted)+'\n')

f.write('recall    macro: ' + '{}'.format(recallmacro)+'\n')
f.write('recall    micro: ' + '{}'.format(recallmicro)+'\n')
f.write('recall weighted: ' + '{}'.format(recallweighted)+'\n')

numpy.savetxt(f,con,fmt="%s")
f.close()
