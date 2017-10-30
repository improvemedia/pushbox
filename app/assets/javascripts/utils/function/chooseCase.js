export default function chooseCase(cases) {
  const chosenCase = cases.find(({ when }) => when);

  return chosenCase ? chosenCase.do() : null;
}