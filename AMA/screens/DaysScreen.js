import React, { useState } from 'react';
import { StyleSheet, Text, View, Button, TextInput, ScrollView } from 'react-native';

import DayContainer from '../components/DayContainer';
import Dates from '../constants/Dates';

const DaysScreen = props => {
    return (
        <ScrollView contentContainerStyle={styles.mainView} >
            <DayContainer day={1} date={Dates.day1Date} />
            <DayContainer day={2} date={Dates.day2Date} />
            <DayContainer day={3} date={Dates.day3Date} />
            <DayContainer day={4} date={Dates.day4Date} />
        </ScrollView>
    )
}


const styles = StyleSheet.create({

    mainView: {
        flex: 1,
        flexWrap: 'wrap',
        flexDirection: 'row',
        backgroundColor: 'grey',
        justifyContent: 'space-around',
        alignItems: 'center'
    },

});


export default DaysScreen;