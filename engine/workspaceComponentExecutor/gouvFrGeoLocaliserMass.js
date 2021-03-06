'use strict'
module.exports = {
  url: require('url'),
  http: require('http'),
  initComponent: function (entity) {
    return entity
  },
  geoLocalise: function (source, specificData) {
    return new Promise((resolve, reject) => {
      var goePromises = []
      var adresseCSV = ''

      for (record of source) {
        var address = {
          street: record[specificData.streetPath],
          town: record[specificData.townPath],
          postalCode: record[specificData.postalCodePath],
          country: record[specificData.countryPath]
        }

        var addressGouvFrFormated = ''
        addressGouvFrFormated = addressGouvFrFormated + (address.street ? address.street + ' ' : '')
        addressGouvFrFormated = addressGouvFrFormated + (address.town ? address.town + ' ' : '')
        addressGouvFrFormated = addressGouvFrFormated + (address.postalCode ? address.postalCode + ' ' : '')
        addressGouvFrFormated = addressGouvFrFormated + (address.country ? address.country + ' ' : '')

        if (addressGouvFrFormated.length > 0) {
          addressGouvFrFormated = addressGouvFrFormated + '\n'
          adresseCSV = adresseCSV + addressGouvFrFormated
        }
      }

      var urlString = 'http://api-adresse.data.gouv.fr/search/csv/'

      const parsedUrl = this.url.parse(urlString)
      const requestOptions = {
        hostname: parsedUrl.hostname,
        path: parsedUrl.path,
        port: parsedUrl.port,
        method: 'POST'
      }
      const request = this.http.request(requestOptions, response => {
        const hasResponseFailed = response.status >= 400
        let responseBody = ''

        if (hasResponseFailed) {
          reject(`Request to ${response.url} failed with HTTP ${response.status}`)
        }

        response.on('data', chunk => {
          responseBody += chunk.toString()
        })

        response.on('end', function () {
          // console.log(responseBody);
          try {
            // resolve(JSON.parse(responseBody));

          } catch (e) {
            resolve({
              error: e
            })
          }
        })
      })
      request.on('error', reject)
      request.end('data=' + adresseCSV)
      resolve([])
    })
  },
  pull: function (data, flowData) {
    // console.log('Object Transformer | pull : ',data,' | ',flowData[0].length);
    return this.geoLocalise(flowData[0].data, data.specificData)
  }
}
