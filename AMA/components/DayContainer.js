import React, { useState } from 'react';
import { StyleSheet, Text, View, Button, TextInput, TouchableOpacity } from 'react-native';

const DayContainer = props => {
    const [numActivies, setNumActivies] = useState(0);
    const [activityWord, setActivityWord] = useState('activities');

    // como modificar estes valores? A funcao e s estados vao continuar aqui por agora

    const changeActivitiesHandler = numActivies => {
        if(numActivies === 0)
            return;

        setNumActivies(numActivies);
        if(numActivies === 1)
            setActivityWord('activity');
        else
            setActivityWord('activities');
    };

    return (
    <TouchableOpacity style={styles.container}>
                <Text style={styles.titleStyle}>Day {props.day}</Text>
                <Text style={styles.dateStyle}>{props.date}</Text>
                <Text style={styles.numActiviesStyle}>{numActivies} {activityWord}</Text>
    </TouchableOpacity>

    );
}


const styles = StyleSheet.create({
    container: {
        backgroundColor: 'red',
        borderRadius: 10,
        paddingHorizontal: 10,
        margin: 20,
        height: '40%',
        width: '40%',
        alignItems: 'center',
        justifyContent: 'center'
    },

    titleStyle: {
        fontSize: 35,
        color: 'black'
    },

    dateStyle: {
        fontSize: 20,
        color: 'black'
    },

    numActiviesStyle: {
        fontSize: 25,
        color: 'white'
    }
});

export default DayContainer;