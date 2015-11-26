function maintest

	[y,fs,bps] = wavread('./records/training/sample0-1.wav');
	mel_coef_entrenamiento_1 = mfcc(y,bps)
	#vector_quantization_1 = vq(mel_coef_entrenamiento_1,16);

end