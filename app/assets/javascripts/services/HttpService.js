import chooseCase from 'utils/function/chooseCase.js';
import qs from 'qs';

const HttpService = (() => {
  let __subscribers = new Map();

  const subscribe = (name, callback) => {
    __subscribers.set(callback, name);
  }

  const _publish = (eventName) => (arg) => {
    __subscribers.forEach((name, callback) => {
      if (eventName === name) callback(arg);
    });

    return arg;
  }

  const _processData = (data) => {
    return chooseCase([
      {
        when: data instanceof FormData,
          do: () => ['multipart/form-data', data]
      },
      {
        when: typeof data === 'object',
          do: () => ['application/json', JSON.stringify(data)]
      },
      {
        when: typeof data === 'string',
          do: () => ['application/x-www-form-urlencoded', data]
      },
      {
        when: true,
          do: () => { throw new Error('HTTPService: Unknown data format.') }
      }
    ])
  }

  const _prepareOptions = ([url, { data, params, ...options }]) => {
    let resultOptions = { ...HttpService.defaults, ...options };

    if (data) {
      const [contentType, body] = _processData(data);

      resultOptions = { ...resultOptions,
        body: body,
        headers: { ...resultOptions.headers,
          'Content-Type': contentType
        },
      };
    }

    if (params) {
      url = `${url}?${qs.stringify(params)}`;
    }

    return [url, resultOptions];
  }

  const _sendRequest = ([url, options]) => {
    return fetch(url, options);
  }

  const _parseResponse = (response) => {
    const contentType = response.headers.get('content-type');

    const contentPromise = contentType && contentType.includes('application/json') ?
      response.json() :
      response.text();

    return new Promise((resolve) => {
      contentPromise.then((content) => resolve([response, content]))
    });
  }

  const _checkStatus = ([response, content]) => {
    if (response.status >= 200 && response.status < 300) {
      return [response, content];
    } else {
      throw new Error(`HTTPService: ${response.statusText}.`);
    }
  }

  const _getContent = ([response, content]) => {
    return content;
  }

  const createRequest = (url, options) => {
    return Promise.resolve([url, options])
      .then(_prepareOptions)
      .then(_publish('beforeRequest'))
      .then(_sendRequest)
      .then(_parseResponse)
      .then(_publish('afterRequest'))
      .then(_checkStatus)
      .then(_getContent)
  }

  const _carryRequestMethod = (method) => (url, options = {}) => {
    return createRequest(url, { method, ...options });
  }

  return {
    subscribe,
    createRequest,
    get:    _carryRequestMethod('GET'),
    put:    _carryRequestMethod('PUT'),
    post:   _carryRequestMethod('POST'),
    patch:  _carryRequestMethod('PATCH'),
    delete: _carryRequestMethod('DELETE'),
  }
})();

HttpService.defaults = {
  credentials: 'include',
  mode: 'cors'
}

export default HttpService;
