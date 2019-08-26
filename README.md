# Face Recognition

Face recognition is one of the most studied problems in computer
vision, and pattern recognition and several approaches have been
proposed over the years. Its primary purpose is to allow the computer to
identify an individual in different environments. Among the main challenges,
we have the face occlusion and the dimensionality of the feature
vector. In this work, we propose a methodology for face recognition under
occlusion using the entropy projection in the curved Gabor filter, to
create a descriptor that presents a representative features vector. However,
the vector obtained by the Curved Gabor with entropy, although
reduced, still presents high dimensionality. In this way, we use Random
Forest as an attribute selector, providing a 97% reduction of the original
vector. A set of experiments was performed to evaluate the proposed
methodology using the SVM classifier and three public image databases:
AR Face, Extended Yale B with occlusion and FERET. The results obtained
in the experiments show significant incremental improvements
when compared to the available approaches in the literature, obtaining
98.05% accuracy for the complete AR Face, 97.26% for FERET and
81.66% with Yale with 50% occlusion.

Full paper at [ISVC'19](https://isvc.net): 

Entropy Projection Curved Gabor with Random Forest and SVM for Face Recognition
