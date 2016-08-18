from sklearn import svm
from sklearn import metrics
from sklearn.cross_validation import train_test_split
from sklearn import cross_validation
from sklearn.datasets import load_iris
from sklearn.metrics import precision_score
from sklearn.datasets import load_svmlight_file
from sklearn.metrics import confusion_matrix

X_train, y_train = load_svmlight_file("/home/eucassio/mestrado/face-recognition/gabor/resultados/processados/03072016/filtro_gabor_curvo_entropia_2pi_ARface_48_56_iluminacao_0_100_6_4x4_5x8_15x15_.txt")


# svm classification
clf = svm.SVC(kernel='rbf', gamma=0.000030517578125, C = 8.0)

predicted = cross_validation.cross_val_predict(clf, X_train,y_train, cv=6)

precisao = precision_score(y_train, predicted, average='micro')  
print precisao
acuracia = metrics.accuracy_score(y_train, predicted)  
print acuracia
con = confusion_matrix(y_train, predicted)
print con
