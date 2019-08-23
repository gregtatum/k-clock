const div = document.createElement('div')
document.body.append(div)
Object.assign(div.style, {
  position: 'absolute',
  top: '30px',
  left: '30px',
  font: '40px sans-serif',
})

setInterval(() => {
  const now = new Date();
  const today = (new Date([now.getFullYear(), now.getMonth() + 1, now.getDate()].join('-') + ' 0:00'))
  const seconds = Math.floor((now - today) / 1000 / 86400 * 100000)
  const kseconds = Math.floor(seconds / 1000)
  const secondsRemainder = Math.floor(seconds % 1000)
  div.innerText = `${kseconds}:${secondsRemainder} ksec`
}, 864);
