import axios from 'axios';

const BACKEND_ROUTES = {
    LOGIN: '/login',
    REGISTER: '/sign_up',
    SAVE_WEIGHT: '/save_weight',
    UPDATE_WEIGHT: '/update_weight',
    DELETE_WEIGHT: '/delete_weight',
    GET_WEIGHT_HISTORY: '/get_weight_history'
}

var state = {token: '', userID: ''};
var userUrl = '/user';
var weightUrl = '/weight';

export const initApiCalls = (backendUrl) => {
    userUrl = backendUrl+userUrl;
    weightUrl = backendUrl+weightUrl;
}

const handleResponse = (res) => {

    switch(res.status) {
        case 'ok':
            return true;
        case 'display-error':
            alert(res.error);
            break;
        case 'error':
            alert('Unhandled Exception!');
            console.log(res);
            break;               
        default:
            alert('Status not returned!');
    }

    return false;
}

export async function login(username, password) {
    const res = await axios.post(userUrl+BACKEND_ROUTES.LOGIN, 
    {username, password});

    if (res.data.status === 'ok') {
        const token = res.data.authToken;
        const payload = Buffer.from(token.split('.')[1], 'base64');
        state = {token: token, userID: JSON.parse(payload.toString()).id};
    }

    return handleResponse(res.data);
}

export async function register(username, password) {

    const res = await axios.post(userUrl+BACKEND_ROUTES.REGISTER, 
    {username, password});

    if (res.data.status === 'ok') {
        alert(res.data.message);
    }

    return handleResponse(res.data);
}

export async function logout() {
    state = {token: '', userID: ''}; // reset state   

    return true;
}

export async function saveWeight(weight) {
    


    const res = await axios.post(weightUrl+BACKEND_ROUTES.SAVE_WEIGHT, 
    {userID: state.userID, weight: weight}, {
        headers: {
            'x-access-token': state.token
        }
    });

    return handleResponse(res.data);
}

export async function updateWeight(weightObj, newWeight) {

    var copy = {};
    Object.assign(copy, weightObj);
    copy.weight = newWeight;

    const res = await axios.put(weightUrl+BACKEND_ROUTES.UPDATE_WEIGHT, 
    copy, {
        headers: {
            'x-access-token': state.token
        }
    });

    return handleResponse(res.data);
}

export async function deleteWeight(weightObj) {
    const res = await axios.post(weightUrl+BACKEND_ROUTES.DELETE_WEIGHT, 
    weightObj, {
        headers: {
            'x-access-token': state.token
        }
    });

    return handleResponse(res.data);
}

export async function getWeightHistory() {

    const res = await axios.get(weightUrl+BACKEND_ROUTES.GET_WEIGHT_HISTORY,  {
        params: {
            userID: state.userID
        },
        headers: {
            'x-access-token': state.token
        }
    });

    if (handleResponse(res.data)) {
        return res.data.message;
    }
    return [];
}
