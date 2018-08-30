A = zeros(100,3);
for i = 1 : 100,
    [LS, CS, DS] = GetEffectOfAlphaOnCascDamage(CaseUCTESummer, 0, Alpha);
    B = [LS DS CS];
    A = A + B;
end
SurvivalvsAlpha(A/100);